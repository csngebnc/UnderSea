using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Bll.Validation.Exceptions;
using UnderSea.Dal.Data;
using UnderSea.Model.Constants;
using UnderSea.Model.Models;
using UnderSea.Model.Models.Joins;

namespace UnderSea.Bll.Services
{
    public class UserService : IUserService
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
            var user = new User { UserName = registerDto.UserName.Trim() };

            if(await _context.Users.AnyAsync(u => u.UserName == registerDto.UserName))
            {
                throw new InvalidParameterException("A megadott felhasználónévvel már van regisztrált felhasználó.");
            }
            
            var result = await _userManager.CreateAsync(user, registerDto.Password);

            var country = new Country {
                Name = registerDto.CountryName,
                OwnerId = user.Id,
                FightPoint = new FightPoint(),
                WorldId = (await _context.Worlds.OrderByDescending(w => w.Id).FirstOrDefaultAsync()).Id
            };

            var materials = await _context.Materials.ToListAsync();
            foreach (var material in materials)
            {
                country.CountryMaterials.Add(new CountryMaterial
                {
                    MaterialId = material.Id,
                    CountryId = country.Id,
                    Multiplier = 1,
                    BaseProduction = 0,
                    Amount = material.MaterialType == MaterialTypeConstants.Pearl ? 5000 : 0,
                });
            }

            _context.Countries.Add(country);
            await _context.SaveChangesAsync();
            return result.Succeeded;
        }

        public async Task<PagedResult<UserRankDto>> GetRanklist(PaginationData pagination, string nameFilter)
        {
            var users = _context.Users
                .OrderByDescending(u => u.Points).AsQueryable()
                .ProjectTo<UserRankDto>(_mapper.ConfigurationProvider);

            if (!string.IsNullOrEmpty(nameFilter) && !string.IsNullOrWhiteSpace(nameFilter))
            {
                users = users.Where(u => u.Name.Contains(nameFilter));
            }

            var pagedList = await users.ToPagedList(pagination.PageSize, pagination.PageNumber);

            foreach (var user in pagedList.Results)
            {
                user.Placement = (await _context.Users.OrderByDescending(u => u.Points).Where(u => u.Points > user.Points).CountAsync()) +1;
            }

            return pagedList;
        }

        public async Task<UserInfoDto> GetUserInfo()
        {
            var user = await _context.Users
                .Include(u => u.Country)
                    .ThenInclude(c => c.World)
                .Where(u => u.Id == _identityService.GetCurrentUserId())
                .FirstOrDefaultAsync();

            return new UserInfoDto
            {
                Id = user.Id,
                Name = user.UserName,
                Round = user.Country.World.Round,
                Placement = (await _context.Users.OrderByDescending(u => u.Points).Where(u => u.Points > user.Points).CountAsync()) + 1
        };
            
        }         
    }
}
