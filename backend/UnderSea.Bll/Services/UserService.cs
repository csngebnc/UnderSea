using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services
{
    public class UserService
    {
        private readonly UserManager<User> _userManager;
        private readonly UnderSeaDbContext _context;
        private readonly IIdentityService _identityService;
        private readonly IMapper _mapper;

        public UserService(UserManager<User> userManager, UnderSeaDbContext context, IMapper mapper, IIdentityService identityService)
        {
            _context = context;
            _mapper = mapper;
            _userManager = userManager;
            _identityService = identityService;
        }

        public async Task<bool> Register(RegisterDto registerDto)
        {
            var user = new User { UserName = registerDto.UserName };
            var result = await _userManager.CreateAsync(user, registerDto.Password);
            return result.Succeeded;
        }

        public async Task<PagedResult<UserRankDto>> GetRanklist(PaginationData pagination)
        {
            return await _context.Users
                .OrderByDescending(u => u.Points)
                .ProjectTo<UserRankDto>(_mapper.ConfigurationProvider)
                .ToPagedList(pagination.PageSize, pagination.PageNumber);
        }

        public async Task<UserInfoDto> GetUserInfo()
        {
            var user = await _context.Users
                .Include(u => u.Country)
                .ThenInclude(c => c.World)
                .Where(u => u.Id == _identityService.GetCurrentUserId())
                .FirstOrDefaultAsync();
            var mapped = _mapper.Map<UserInfoDto>(user);
            mapped.Placement = (await _context.Users.OrderByDescending(u => u.Points).ToListAsync()).FindIndex(0, u => u.Id == mapped.Id);
            return mapped;
        }

        public async Task<CountryDetailsDto> GetUserDetails()
        {
            return await _context.Countries
                .Where(u => u.OwnerId == _identityService.GetCurrentUserId())
                .Include(c => c.CountryBuildings)
                    .ThenInclude(cb => cb.Building)
                        .ThenInclude(b => b.BuildingEffects)
                            .ThenInclude(be => be.Effect)
                .Include(c => c.CountryUnits)
                    .ThenInclude(cu => cu.Unit)
                .ProjectTo<CountryDetailsDto>(_mapper.ConfigurationProvider)
                .FirstOrDefaultAsync();
        }

        public async Task ChangeCountryName(string name)
        {
            var country = await _context.Countries.Where(c => c.OwnerId == _identityService.GetCurrentUserId()).FirstOrDefaultAsync();
            country.Name = name;
            await _context.SaveChangesAsync();
        }
    }
}
