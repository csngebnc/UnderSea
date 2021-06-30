using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Extensions;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Bll.Validation;
using UnderSea.Bll.Validation.Exceptions;
using UnderSea.Dal.Data;
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
            PaginationDataValidator validator = new PaginationDataValidator();
            validator.Validate(data);

            var userId = GetUserId();
            var user = await _context.Users.Where(u => u.Id == userId).Include(u => u.Country).ThenInclude(c => c.Attacks).ThenInclude(a => a.DefenderCountry).FirstOrDefaultAsync();

            var attackableusers = _context.Users.Where(c => c.Id != userId && !user.Country.Attacks.Select(a => a.DefenderCountry.OwnerId).Contains(c.Id)).ProjectTo<AttackableUserDto>(_mapper.ConfigurationProvider);

            if (!string.IsNullOrEmpty(name) && !string.IsNullOrWhiteSpace(name))
            {
                attackableusers = attackableusers.Where(u => u.UserName.Contains(name));
            }

            var attackable_users = await attackableusers.ToPagedList(data.PageSize,data.PageNumber);
            return attackable_users;
        }

        public async Task<IEnumerable<BattleUnitDto>> GetUserUnitsAsync()
        {
            var country = await GetCountry();

            var userunits = await _context.CountryUnits
                .Include(c => c.Unit)
                .Where(c => c.CountryId == country.Id)
                .Select(c => c.Unit)
                .ProjectTo<BattleUnitDto>(_mapper.ConfigurationProvider)
                .ToListAsync();
            
            return userunits;
        }

        public async Task<PagedResult<LoggedAttackDto>> GetLoggedAttacksAsync(PaginationData data)
        {
            PaginationDataValidator validator = new PaginationDataValidator();
            validator.Validate(data);

            var country = await GetCountry();
            
            var attacks = await _context.Attacks
                                            .Where(c => c.DefenderCountryId == country.Id || c.AttackerCountryId == country.Id)
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

        public async Task<IEnumerable<UnitDto>> GetAllUnitsAsync()
        {
            var country = await _context.Countries.Where(c => c.OwnerId == _identityService.GetCurrentUserId()).Include(c => c.CountryUnits).FirstOrDefaultAsync();
            if (country == null)
                throw new NotExistsException("A bejelentkezett felhasználóhoz nem tartozik ország.");

            return (await _context.Units.ToListAsync())
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
                        Price = unit.Price,
                        CurrentCount = count
                    };


                });
        }

        public async Task BuyUnitAsync(BuyUnitDto unitDto)
        {
            BuyUnitValidator validator = new BuyUnitValidator(_context);
            await validator.ValidateAsync(unitDto);

            var country = await GetCountry();

            var unit = await _context.Units.Where(c => c.Id == unitDto.UnitId).FirstOrDefaultAsync();
            if (unit == null) throw new NotExistsException("Nem létezik ilyen egység, amit meg lehetne vásárolni.");

            var unitSum = country.CountryUnits.Select(cu => cu.Count).Sum();
            if (country.MaxUnitCount - unitSum - unitDto.Count < 0)
                throw new InvalidParameterException("Nem lehetséges ez a művelet: a maximális egység számánál nem lehet több a felhasználó egységeinek száma.");


            var counit = await _context.CountryUnits.Where(c => c.CountryId == country.Id && c.UnitId == unit.Id).FirstOrDefaultAsync();

            if ((unit.Price * unitDto.Count) <= country.Pearl)
            {
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

                country.Pearl -= unit.Price * unitDto.Count;
            }
            else
            {
                throw new InvalidParameterException("Nincs elég gyöngy az egységek megvásárlásához.");
            }

            await _context.SaveChangesAsync();
        }

        public async Task AttackAsync(SendAttackDto attackDto)
        {
            SendAttackValidator validatior = new SendAttackValidator(_context);
            await validatior.ValidateAsync(attackDto);

            var attackerCountry = await GetCountry();

            var attackedCountry = await _context.Countries.Where(c => c.Id == attackDto.AttackedCountryId).FirstOrDefaultAsync();
            if (attackedCountry == null) throw new NotExistsException("Nem létezik ilyen ország, ami megtámadható lenne.");

            var world = await _context.Worlds.FirstOrDefaultAsync();
            if (world == null) throw new NotExistsException("Nem létezik ilyen világ, ahol támadni lehet.");

            var secondAttack = await _context.Attacks
                .AnyAsync(c => c.AttackerCountryId == attackerCountry.Id && c.DefenderCountryId == attackDto.AttackedCountryId && c.AttackerCountry.World.Round == world.Round);
            if (secondAttack) throw new InvalidParameterException("Nem támadható ugyanaz az ország egy körben!");

            if(attackerCountry.Id == attackDto.AttackedCountryId) throw new InvalidParameterException("Nem támadhatja meg saját magát az ország.");

            await AttackLogic(attackerCountry, attackedCountry, attackDto);
        }

        public async Task AttackLogic(Country attackerCountry, Country attackedCountry, SendAttackDto attackDto)
        {
            using (var transaction = _context.Database.BeginTransaction())
            {
                var attack = new Attack()
                {
                    AttackerCountryId = attackerCountry.Id,
                    DefenderCountryId = attackedCountry.Id,
                    AttackRound = attackerCountry.World.Round,
                    AttackUnits = new List<AttackUnit>(),
                    WinnerId = null
                };

                foreach (var unit in attackDto.Units)
                {
                    var attackUnit = new AttackUnit()
                    {
                        Count = unit.Count,
                        UnitId = unit.UnitId
                    };

                    var cunit = attackerCountry.CountryUnits.Where(c => c.CountryId == attackerCountry.Id && c.UnitId == unit.UnitId).FirstOrDefault();
                    if (cunit == null)
                    {
                        await transaction.RollbackAsync();
                        throw new InvalidParameterException("Nincsen ilyen egysége az országnak.");
                    }

                    if (cunit.Count >= unit.Count)
                    {
                        cunit
                            .Count -= unit.Count;
                    }
                    else
                    {
                        await transaction.RollbackAsync();
                        throw new InvalidParameterException("Nincs elegendő egység amit a támadáshoz kértek.");
                    }

                    attack.AttackUnits.Add(attackUnit);

                }

                _context.Attacks.Add(attack);

                await _context.SaveChangesAsync();
                await transaction.CommitAsync();
            }
        }

        private string GetUserId()
        {
            var userId = _identityService.GetCurrentUserId();

            return userId;
        }

        private async Task<Country> GetCountry()
        {
            var userId = GetUserId();

            var country = await _context.Countries.Include(w => w.World).Include(c => c.CountryUnits).Where(c => c.OwnerId == userId).FirstOrDefaultAsync();
            if (country == null) throw new NotExistsException("A bejelentkezett felhasználóhoz nem tartozik ország.");

            return country;
        }
    }
}
