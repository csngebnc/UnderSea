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

        public async Task<ICollection<BattleUnitDto>> GetUserUnitsAsync()
        {
            var country = await _context.Countries
                .Include(c => c.CountryUnits)
                .SingleOrDefaultAsync(c => c.OwnerId == _identityService.GetCurrentUserId());

            var units = await _context.Units.ToListAsync();

            return country.CountryUnits
                .Where(unit => unit.Unit.Name != UnitNameConstants.Felfedezo)
                .ToList()
                .GroupBy(ug => new { ug.UnitId, Level = ug.GetLevel() })
                .Select(gb =>
                {
                    var defaultUnit = units.SingleOrDefault(du => du.Id == gb.Key.UnitId);
                    return new BattleUnitDto
                    {
                        Id = gb.Key.UnitId,
                        Name = defaultUnit.Name,
                        Count = gb.Sum(uu => uu.Count),
                        ImageUrl = defaultUnit.ImageUrl,
                        Level = gb.Key.Level
                    };
                }).ToList();
        }

        public async Task<IEnumerable<BattleUnitDto>> GetUserAllUnitsAsync()
        {
            var country = await _context.Countries
                .Include(c => c.CountryUnits)
                .Include(c => c.SentSpies)
                .Include(c => c.World)
                .SingleOrDefaultAsync(c => c.OwnerId == _identityService.GetCurrentUserId());

            var units = await this.GetUserUnitsAsync();

            var attackUnits = await _context.AttackUnits
                .Include(a => a.Attack)
                .Where(a => a.Attack.AttackRound == country.World.Round &&
                    a.Attack.AttackerCountryId == country.Id)
                .ToListAsync();

            foreach (var unit in attackUnits)
            {
                units.SingleOrDefault(u => u.Id == unit.UnitId && u.Level == unit.GetLevel()).Count += unit.Count;
            }

            var spy = await _context.Units
                .Include(s => s.UnitLevels)
                .SingleOrDefaultAsync(u => u.Name == UnitNameConstants.Felfedezo);

            var spiesInCountry = country.CountryUnits.SingleOrDefault(u => u.UnitId == spy.Id)?.Count ?? 0;
            var spiesNotInCountry = country.SentSpies
                .Where(sr => sr.Round == country.World.Round && sr.WinnerId == null)
                .Select(sr => sr.NumberOfSpies)
                .Sum();

            units.Add(new BattleUnitDto
            {
                Id = spy.Id,
                Name = spy.Name,
                Count = spiesInCountry + spiesNotInCountry,
                ImageUrl = spy.ImageUrl,
                Level = spy.UnitLevels.FirstOrDefault().Level
            });

            return units;
        }

        public async Task<PagedResult<LoggedAttackDto>> GetLoggedAttacksAsync(PaginationData data)
        {
            var country = await GetCountry();

            var attacks = await _context.Attacks
                                            .Where(c => (c.DefenderCountryId == country.Id && c.AttackRound != country.World.Round) || c.AttackerCountryId == country.Id)
                                            .OrderByDescending(a => a.AttackRound)
                                            .Include(a => a.AttackUnits)
                                                .ThenInclude(au => au.Unit)
                                            .Include(a => a.AttackerCountry)
                                            .Include(a => a.DefenderCountry)
                                            .ToPagedList(data.PageSize, data.PageNumber);

            var units = await _context.Units.ToListAsync();
            var result = new List<LoggedAttackDto>();
            foreach (var attack in attacks.Results)
            {
                result.Add(
                    new LoggedAttackDto
                    {
                        AttackedCountryName = country.Name == attack.DefenderCountry.Name ? attack.AttackerCountry.Name : attack.DefenderCountry.Name,
                        Units = attack.AttackUnits
                .GroupBy(ug => new { ug.UnitId, Level = ug.GetLevel() })
                .Select(gb =>
                {
                    var defaultUnit = units.SingleOrDefault(du => du.Id == gb.Key.UnitId);
                    return new BattleUnitDto
                    {
                        Id = gb.Key.UnitId,
                        Name = defaultUnit.Name,
                        Count = gb.Sum(uu => uu.Count),
                        ImageUrl = defaultUnit.ImageUrl,
                        Level = gb.Key.Level
                    };
                }).ToList(),
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
                .Include(u => u.UnitLevels)
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
                        UnitLevels = unit.UnitLevels.Select(u =>
                        {
                            return new UnitLevelDto
                            {
                                AttackPoint = u.AttackPoint,
                                DefensePoint = u.DefensePoint,
                                MinimumBattles = u.MinimumBattles,
                                Level = u.Level
                            };
                        }).ToList(),
                        MercenaryPerRound = unit.MercenaryPerRound,
                        SupplyPerRound = unit.SupplyPerRound,
                        RequiredMaterials = unit.UnitMaterials.Select(c =>
                                    new MaterialDto
                                    {
                                        Id = c.MaterialId,
                                        Name = c.Material.Name,
                                        Amount = c.Amount,
                                        ImageUrl = c.Material.ImageUrl
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

            var spyUnit = await _context.Units
                .Include(s => s.UnitLevels)
                .SingleOrDefaultAsync(c => c.Name == UnitNameConstants.Felfedezo);
            var spies = country.CountryUnits.SingleOrDefault(cu => cu.UnitId == spyUnit.Id);

            return new BattleUnitDto
            {
                Id = spyUnit.Id,
                Name = spyUnit.Name,
                ImageUrl = spyUnit.ImageUrl,
                Count = spies == null ? 0 : spies.Count,
                Level = spyUnit.UnitLevels.FirstOrDefault().Level
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
                    throw new InvalidParameterException(nameof(country.MaxUnitCount), "Nem lehetséges ez a művelet: a maximális egység számánál nem lehet több a felhasználó egységeinek száma.");
                }

                var counit = await _context.CountryUnits.Where(c => c.CountryId == country.Id && c.UnitId == unit.Id && c.BattlesPlayed == 0)
                                                        .FirstOrDefaultAsync();

                if (counit == null)
                {
                    CountryUnit countryUnit = new CountryUnit()
                    {
                        UnitId = unit.Id,
                        CountryId = country.Id,
                        Count = unitDto.Count,
                        BattlesPlayed = 0
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
                .FirstOrDefaultAsync(u => u.Name == UnitNameConstants.Felfedezo))
                .Id;

            if (attackDto.Units.Any(au => au.UnitId == spyId))
            {
                throw new InvalidParameterException("unit", "Kémet nem küldhetsz támadni.");
            }

            var secondAttack = await _context.Attacks
                .AnyAsync(c => c.AttackerCountryId == attackerCountry.Id &&
                    c.DefenderCountryId == attackDto.AttackedCountryId &&
                    c.AttackRound == world.Round);

            if (secondAttack)
            {
                throw new InvalidParameterException("country", "Nem támadható ugyanaz az ország egy körben!");
            }

            if (attackerCountry.Id == attackDto.AttackedCountryId)
            {
                throw new InvalidParameterException("country", "Nem támadhatja meg saját magát az ország.");
            }

            attackDto.Units = attackDto.Units.GroupBy(u => new { u.UnitId, u.Level })
                .Select(u => new AttackUnitDto
                {
                    UnitId = u.Key.UnitId,
                    Level = u.Key.Level,
                    Count = u.Sum(uu => uu.Count)
                }).ToList();

            await AttackLogic(attackerCountry, attackedCountry, attackDto);
        }

        public async Task AttackLogic(Country attackerCountry, Country attackedCountry, SendAttackDto attackDto)
        {
            var generalId = (await _context.Units.SingleOrDefaultAsync(u => u.Name == UnitNameConstants.Hadvezer)).Id;
            if (!attackDto.Units.Any(u => u.UnitId == generalId))
            {
                throw new InvalidParameterException("unit", "A támadáshoz legalább egy hadvezért is küldeni kell.");
            }

            var attack = new Attack()
            {
                AttackerCountryId = attackerCountry.Id,
                DefenderCountryId = attackedCountry.Id,
                AttackRound = attackerCountry.World.Round,
                AttackUnits = attackDto.Units.SelectMany(unit =>
                {
                    var cunits = attackerCountry.CountryUnits
                    .Where(cu => cu.UnitId == unit.UnitId && cu.GetLevel() == unit.Level)
                    .OrderByDescending(cu => cu.BattlesPlayed)
                    .ToList();

                    var attackUnits = new List<AttackUnit>();
                    foreach (var cunit in cunits)
                    {
                        if (cunit.Count < (unit.Count - attackUnits.Sum(a => a.Count)))
                        {
                            attackUnits.Add(new AttackUnit
                            {
                                UnitId = cunit.UnitId,
                                BattlesPlayed = cunit.BattlesPlayed,
                                Count = cunit.Count
                            });
                            attackerCountry.CountryUnits.FirstOrDefault(cu => cu.UnitId == cunit.UnitId && cu.BattlesPlayed == cunit.BattlesPlayed).Count = 0;
                        }
                        else
                        {
                            var newAttackUnit = new AttackUnit
                            {
                                UnitId = cunit.UnitId,
                                BattlesPlayed = cunit.BattlesPlayed,
                                Count = (unit.Count - attackUnits.Sum(a => a.Count))
                            };
                            attackUnits.Add(newAttackUnit);
                            attackerCountry.CountryUnits.FirstOrDefault(cu => cu.UnitId == cunit.UnitId && cu.BattlesPlayed == cunit.BattlesPlayed).Count -= newAttackUnit.Count;
                            break;
                        }
                    }

                    if((unit.Count != attackUnits.Sum(a => a.Count)))
                    {
                        throw new InvalidParameterException("unit","Nem áll rendelkezésre elég egység.");
                    }

                    return attackUnits;
                }).ToList(),
                WinnerId = null
            };

            _context.Attacks.Add(attack);

            await _context.SaveChangesAsync();

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
                throw new InvalidParameterException("country", "Nem kémlelheti saját magát az ország.");
            }

            var attackerSpyUnits = country.CountryUnits
                .FirstOrDefault(cu => cu.Unit.Name == UnitNameConstants.Felfedezo);

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
