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
using UnderSea.Dal.Data;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services
{
    public class BattleService
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

        public async Task<PagedResult<AttackableUserDto>> GetAttackableUsersAsync(PaginationData data)
        {
            var userId = GetUserId();

            var attackableusers = await _context.Users.Where(c => c.Id != userId).ProjectTo<AttackableUserDto>(_mapper.ConfigurationProvider).ToPagedList(data.PageSize,data.PageNumber);
            return attackableusers;
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
            var country = await GetCountry();
            
            var attacks = await _context.Attacks
                                            .Where(c => c.DefenderCountryId == country.Id || c.AttackerCountryId == country.Id)
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
                throw new Exception();

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
            var country = await GetCountry();

            var unit = await _context.Units.Where(c => c.Id == unitDto.UnitId).FirstOrDefaultAsync();
            if (unit == null) throw new NullReferenceException();

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
                throw new InvalidOperationException();
            }

            await _context.SaveChangesAsync();
        }

        public async Task AttackAsync(SendAttackDto attackDto)
        {
            var attackerCountry = await GetCountry();

            var attackedCountry = await _context.Countries.Where(c => c.Id == attackDto.AttackedCountryId).FirstOrDefaultAsync();
            if (attackedCountry == null) throw new NullReferenceException();

            await AttackLogic(attackerCountry, attackedCountry, attackDto);
        }

        public async Task AttackLogic(Country attackerCountry, Country attackedCountry, SendAttackDto attackDto)
        {
            using (var transaction = _context.Database.BeginTransaction())
            {
                Attack attack = new Attack()
                {
                    AttackerCountryId = attackerCountry.Id,
                    DefenderCountryId = attackedCountry.Id,
                    AttackRound = attackerCountry.World.Round,
                    WinnerId = null
                };

                var newAttack = _context.Attacks.Add(attack);

                if (newAttack.Entity == null)
                {
                    await transaction.RollbackAsync();
                    throw new InvalidOperationException();
                }

                foreach (var unit in attackDto.Units)
                {
                    AttackUnit attackUnit = new AttackUnit()
                    {
                        AttackId = newAttack.Entity.Id,
                        Count = unit.Count,
                        UnitId = unit.UnitId
                    };

                    var cunit = attackerCountry.CountryUnits.Where(c => c.CountryId == attackerCountry.Id && c.UnitId == unit.UnitId).FirstOrDefault();
                    if (cunit == null)
                    {
                        await transaction.RollbackAsync();
                        throw new InvalidOperationException();
                    }

                    if (cunit.Count >= unit.Count)
                    {
                        cunit
                            .Count -= unit.Count;
                    }
                    else
                    {
                        await transaction.RollbackAsync();
                        throw new InvalidOperationException();
                    }

                    var newAttackUnit = _context.AttackUnits.Add(attackUnit);

                    if (newAttackUnit.Entity == null)
                    {
                        await transaction.RollbackAsync();
                        throw new InvalidOperationException();
                    }
                }

                await _context.SaveChangesAsync();
                await transaction.CommitAsync();
            }
        }

        private string GetUserId()
        {
            var userId = _identityService.GetCurrentUserId();
            if (string.IsNullOrEmpty(userId)) throw new NullReferenceException();

            return userId;
        }

        private async Task<Country> GetCountry()
        {
            var userId = GetUserId();

            var country = await _context.Countries.Include(w => w.World).Include(c => c.CountryUnits).Where(c => c.OwnerId == userId).FirstOrDefaultAsync();
            if (country == null) throw new NullReferenceException();

            return country;
        }
    }
}
