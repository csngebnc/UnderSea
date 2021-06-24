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
using UnderSea.Dal.Data;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services
{
    public class BattleService
    {
        private readonly UnderSeaDbContext _context;
        private readonly IHttpContextAccessor httpContextAccessor;
        private readonly IMapper _mapper;

        public BattleService(UnderSeaDbContext context, IHttpContextAccessor httpContextAccessor, IMapper mapper)
        {
            _context = context;
            this.httpContextAccessor = httpContextAccessor;
            _mapper = mapper;
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

            var userunits = await _context.Units.Where(c => c.CountryUnits.Where(a => a.CountryId == country.Id).Any()).ProjectTo<BattleUnitDto>(_mapper.ConfigurationProvider).ToListAsync();
            return userunits;
        }

        public async Task<PagedResult<LoggedAttackDto>> GetLoggedAttacksAsync(PaginationData data)
        {
            var country = await GetCountry();

            var loggedattacks = await _context.Attacks.Where(c => c.DefenderCountryId == country.Id || c.AttackerCountryId == country.Id).ProjectTo<LoggedAttackDto>(_mapper.ConfigurationProvider).ToPagedList(data.PageSize, data.PageNumber);
            return loggedattacks;
        }

        public async Task<IEnumerable<UnitDto>> GetAllUnitsAsync()
        {
            var units = await _context.Units.ProjectTo<UnitDto>(_mapper.ConfigurationProvider).ToListAsync();
            return units;
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

        private string GetUserId()
        {
            var userId = httpContextAccessor.GetCurrentUserId();
            if (string.IsNullOrEmpty(userId)) throw new NullReferenceException();

            return userId;
        }

        private async Task<Country> GetCountry()
        {
            var userId = GetUserId();

            var country = await _context.Countries.Where(c => c.OwnerId == userId).FirstOrDefaultAsync();
            if (country == null) throw new NullReferenceException();

            return country;
        }
    }
}
