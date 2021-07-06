using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Dtos.Material;
using UnderSea.Bll.Dtos.Spy;
using UnderSea.Bll.Dtos.Unit;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Bll.Validation.Exceptions;
using UnderSea.Dal.Data;
using UnderSea.Model.Constants;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services
{
    public class BattleService : IBattleService
    {
        private readonly UnderSeaDbContext _context;
        private readonly IIdentityService _identityService;
        private readonly IMapper _mapper;

        public BattleService(UnderSeaDbContext context, IMapper mapper, IIdentityService identityService)
        {
            _context = context;
            _mapper = mapper;
            _identityService = identityService;
        }

        public async Task<PagedResult<AttackableUserDto>> GetAttackableUsersAsync(PaginationData data, string name)
        {
            var userId = _identityService.GetCurrentUserId();
            var user = await _context.Users.Where(u => u.Id == userId)
                .Include(u => u.Country)
                    .ThenInclude(e => e.World)
                .FirstOrDefaultAsync();

            var attackableusers = _context.Users
                                    .Include(u => u.Country)
                                        .ThenInclude(c => c.Defenses)
                                    .Where(u => u.Id != userId
                                          && !u.Country.Defenses.Any(d => d.AttackerCountryId == user.Country.Id
                                                && d.AttackRound == user.Country.World.Round))
                                    .ProjectTo<AttackableUserDto>(_mapper.ConfigurationProvider);

            if (!string.IsNullOrEmpty(name) && !string.IsNullOrWhiteSpace(name))
            {
                attackableusers = attackableusers.Where(u => u.UserName.Contains(name));
            }

            var attackable_users = await attackableusers.ToPagedList(data.PageSize, data.PageNumber);
            return attackable_users;
        }

        public async Task<IEnumerable<BattleUnitDto>> GetUserUnitsAsync()
        {
            var country = await GetCountry();

            var userunits = await _context.CountryUnits
                .Include(c => c.Unit)
                .Where(c => c.CountryId == country.Id && c.Unit.Name != UnitConstants.Felfedezo)
                .Select(c => c.Unit)
                .ProjectTo<BattleUnitDto>(_mapper.ConfigurationProvider)
                .ToListAsync();

            return userunits;
        }

        public async Task<IEnumerable<BattleUnitDto>> GetUserAllUnitsAsync()
        {
            var country = await GetCountry();
            var userunits = await _context.CountryUnits
                .Include(c => c.Unit)
                .Where(c => c.CountryId == country.Id && c.Unit.Name != UnitConstants.Felfedezo)
                .ToListAsync();

            var attackUnits = await _context.AttackUnits
                .Include(a => a.Attack)
                .Where(a => a.Attack.AttackRound == country.World.Round && a.Attack.AttackerCountryId == country.Id)
                .ToListAsync();

            foreach (var unit in attackUnits)
            {
                userunits.Where(u => u.UnitId == unit.Id).FirstOrDefault().Count += unit.Count;
            }

            return userunits.Select(uu =>
            {
                return new BattleUnitDto
                {
                    Id = uu.UnitId,
                    Name = uu.Unit.Name,
                    Count = uu.Count,
                    ImageUrl = uu.Unit.ImageUrl
                };
            });
        }

        public async Task<PagedResult<LoggedAttackDto>> GetLoggedAttacksAsync(PaginationData data)
        {
            var country = await GetCountry();

            var attacks = await _context.Attacks
                                            .Where(c => (c.DefenderCountryId == country.Id && c.AttackRound != country.World.Round+1) || c.AttackerCountryId == country.Id)
                                            .OrderByDescending(a => a.AttackRound)
                                            .Include(a => a.AttackUnits)
                                                .ThenInclude(au => au.Unit)
                                            .Include(a => a.DefenderCountry)
                                            .ToPagedList(data.PageSize, data.PageNumber);

            var result = new List<LoggedAttackDto>();
            foreach (var attack in attacks.Results)
            {
                result.Add(
                    new LoggedAttackDto
                    {
                        AttackedCountryName = attack.DefenderCountry.Name,
                        Units = _mapper.Map<ICollection<BattleUnitDto>>(attack.AttackUnits),
                        Outcome = attack.WinnerId == null ? Model.Enums.FightOutcome.NotPlayedYet :
                                    attack.WinnerId == _identityService.GetCurrentUserId() ?
                                                Model.Enums.FightOutcome.CurrentUser : Model.Enums.FightOutcome.OtherUser
                    }
                );
            }

            return new PagedResult<LoggedAttackDto>
            {
                AllResultsCount = attacks.AllResultsCount,
                PageNumber = attacks.PageNumber,
                PageSize = attacks.PageSize,
                Results = result
            };
        }

        public async Task<PagedResult<SpyReportDto>> GetLoggedSpyReportsAsync(PaginationData data)
        {
            var country = await _context.Countries
                .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                .FirstOrDefaultAsync();

            var spyreports = await _context.SpyReports.Where(sr => sr.SpySenderCountryId == country.Id)
                .Include(sr => sr.SpiedCountry)
                .OrderByDescending(sr => sr.Round)
                .ToPagedList(data.PageSize, data.PageNumber);

            return new PagedResult<SpyReportDto>
            {
                AllResultsCount = spyreports.AllResultsCount,
                PageNumber = spyreports.PageNumber,
                PageSize = spyreports.PageSize,
                Results = spyreports.Results.Select(sr =>
                {
                    return new SpyReportDto
                    {
                        SpyReportId = sr.Id,
                        SpiedCountryName = sr.SpiedCountry.Name,
                        DefensePoints = sr.DefensePoints,
                        OutCome = sr.WinnerId == null ? Model.Enums.FightOutcome.NotPlayedYet :
                                    sr.WinnerId == _identityService.GetCurrentUserId() ?
                                                Model.Enums.FightOutcome.CurrentUser : Model.Enums.FightOutcome.OtherUser
                    };
                })
            };

        }

        public async Task<IEnumerable<UnitDto>> GetAllUnitsAsync()
        {
            var country = await _context.Countries.Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                                                  .Include(c => c.CountryUnits)
                                                  .FirstOrDefaultAsync();
            if (country == null)
            {
                throw new NotExistsException("A bejelentkezett felhasználóhoz nem tartozik ország.");
            }

            return (await _context.Units
                .Include(um => um.UnitMaterials)
                .ThenInclude(m => m.Material)
                .ToListAsync())
                .Select(unit =>
                {
                    var unitCount = country.CountryUnits.Where(cu => cu.UnitId == unit.Id).FirstOrDefault();
                    var count = 0;
                    if (unitCount != null)
                        count = unitCount.Count;

                    return new UnitDto
                    {
                        Id = unit.Id,
                        Name = unit.Name,
                        AttackPoint = unit.AttackPoint,
                        DefensePoint = unit.DefensePoint,
                        MercenaryPerRound = unit.MercenaryPerRound,
                        SupplyPerRound = unit.SupplyPerRound,
                        RequiredMaterials = unit.UnitMaterials.Select(c =>
                                    new MaterialDto
                                    {
                                        Id = c.MaterialId,
                                        Name = c.Material.Name,
                                        Amount = c.Amount
                                    })
                                    .ToList(),
                        CurrentCount = count,
                        ImageUrl = unit.ImageUrl
                    };
                });
        }

        public async Task<BattleUnitDto> GetSpies()
        {
            var country = await _context.Countries
                .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                .Include(c => c.CountryUnits)
                .FirstOrDefaultAsync();

            var spyUnit = await _context.Units.SingleOrDefaultAsync(c => c.Name == UnitConstants.Felfedezo);
            var spies = country.CountryUnits.SingleOrDefault(cu => cu.UnitId == spyUnit.Id);

            return new BattleUnitDto
            {
                Id = spyUnit.Id,
                Name = spyUnit.Name,
                ImageUrl = spyUnit.ImageUrl,
                Count = spies == null ? 0 : spies.Count
            };
        }

        public async Task BuyUnitAsync(BuyUnitDto unitsDto)
        {
            var userId = _identityService.GetCurrentUserId();

            var country = await _context.Countries.Include(w => w.World)
                                                  .Include(c => c.CountryMaterials)
                                                  .Include(c => c.CountryUnits)
                                                  .Where(c => c.OwnerId == userId)
                                                  .FirstOrDefaultAsync();

            foreach (var unitDto in unitsDto.Units)
            {
                var unit = await _context.Units
                    .Include(um => um.UnitMaterials)
                    .ThenInclude(m => m.Material)
                    .Where(c => c.Id == unitDto.UnitId)
                    .FirstOrDefaultAsync();

                if (unit == null)
                {
                    throw new NotExistsException("Nem létezik ilyen egység, amit meg lehetne vásárolni.");
                }

                var unitSum = country.CountryUnits.Select(cu => cu.Count).Sum();
                if (country.MaxUnitCount - unitSum - unitDto.Count < 0)
                {
                    throw new InvalidParameterException("Nem lehetséges ez a művelet: a maximális egység számánál nem lehet több a felhasználó egységeinek száma.");
                }

                var counit = await _context.CountryUnits.Where(c => c.CountryId == country.Id && c.UnitId == unit.Id)
                                                        .FirstOrDefaultAsync();

                if (counit == null)
                {
                    CountryUnit countryUnit = new CountryUnit()
                    {
                        UnitId = unit.Id,
                        CountryId = country.Id,
                        Count = unitDto.Count
                    };
                    _context.CountryUnits.Add(countryUnit);
                }
                else
                {
                    counit.Count += unitDto.Count;
                }

                foreach (var materialRequirement in unit.UnitMaterials)
                {
                    country.CountryMaterials.SingleOrDefault(cm => cm.MaterialId == materialRequirement.MaterialId).Amount -= materialRequirement.Amount * unitDto.Count;
                }
            }

            await _context.SaveChangesAsync();
        }

        public async Task AttackAsync(SendAttackDto attackDto)
        {
            var attackerCountry = await GetCountry();

            var attackedCountry = await _context.Countries.Where(c => c.Id == attackDto.AttackedCountryId).FirstOrDefaultAsync();
            if (attackedCountry == null)
            {
                throw new NotExistsException("Nem létezik ilyen ország, ami megtámadható lenne.");
            }

            var world = await _context.Worlds.FirstOrDefaultAsync();
            if (world == null)
            {
                throw new NotExistsException("Nem létezik ilyen világ, ahol támadni lehet.");
            }

            var spyId = (await _context.Units
                .FirstOrDefaultAsync(u => u.Name == UnitConstants.Felfedezo))
                .Id;

            if (attackDto.Units.Any(au => au.UnitId == spyId))
            {
                throw new InvalidParameterException("Kémet nem küldhetsz támadni.");
            }

            var secondAttack = await _context.Attacks
                .AnyAsync(c => c.AttackerCountryId == attackerCountry.Id &&
                    c.DefenderCountryId == attackDto.AttackedCountryId &&
                    c.AttackRound == world.Round);

            if (secondAttack)
            {
                throw new InvalidParameterException("Nem támadható ugyanaz az ország egy körben!");
            }

            if (attackerCountry.Id == attackDto.AttackedCountryId)
            {
                throw new InvalidParameterException("Nem támadhatja meg saját magát az ország.");
            }

            attackDto.Units = attackDto.Units.GroupBy(u => u.UnitId)
                .Select(u => new AttackUnitDto
                {
                    UnitId = u.Key,
                    Count = u.Sum(uu => uu.Count)
                }).ToList();

            await AttackLogic(attackerCountry, attackedCountry, attackDto);
        }

        public async Task SpyAsync(SendSpyDto spies)
        {
            var country = await _context.Countries
                .Include(c => c.World)
                .Include(c => c.CountryUnits)
                    .ThenInclude(cu => cu.Unit)
                .FirstOrDefaultAsync(c => c.OwnerId == _identityService.GetCurrentUserId());

            if (spies.SpiedCountryId == country.Id)
            {
                throw new InvalidParameterException("Nem kémlelheti saját magát az ország.");
            }

            var attackerSpyUnits = country.CountryUnits
                .FirstOrDefault(cu => cu.Unit.Name == UnitConstants.Felfedezo);

            if (attackerSpyUnits == null)
                throw new NotExistsException("Nincsenek kém egységek, amiket el lehetne küldeni!");

            attackerSpyUnits.Count -= spies.SpyCount;

            var spyreport = new SpyReport
            {
                SpySenderCountryId = country.Id,
                SpiedCountryId = spies.SpiedCountryId,
                NumberOfSpies = spies.SpyCount,
                Round = country.World.Round
            };

            _context.SpyReports.Add(spyreport);
            await _context.SaveChangesAsync();
        }

        public async Task AttackLogic(Country attackerCountry, Country attackedCountry, SendAttackDto attackDto)
        {
            var attack = new Attack()
            {
                AttackerCountryId = attackerCountry.Id,
                DefenderCountryId = attackedCountry.Id,
                AttackRound = attackerCountry.World.Round,
                AttackUnits = attackDto.Units.Select(unit =>
                {
                    var attackUnit = new AttackUnit()
                    {
                        Count = unit.Count,
                        UnitId = unit.UnitId
                    };

                    var cunit = attackerCountry.CountryUnits.FirstOrDefault(c => c.UnitId == unit.UnitId);
                    if (cunit == null)
                    {
                        throw new InvalidParameterException("Nincsen ilyen egysége az országnak.");
                    }

                    cunit.Count -= unit.Count;

                    return attackUnit;
                }).ToList(),
                WinnerId = null
            };

            _context.Attacks.Add(attack);

            await _context.SaveChangesAsync();

        }

        private async Task<Country> GetCountry()
        {
            var userId = _identityService.GetCurrentUserId();

            var country = await _context.Countries.Include(w => w.World)
                                                  .Include(c => c.CountryUnits)
                                                  .Where(c => c.OwnerId == userId)
                                                  .FirstOrDefaultAsync();

            if (country == null)
            {
                throw new NotExistsException("A bejelentkezett felhasználóhoz nem tartozik ország.");
            }

            return country;
        }
    }
}
