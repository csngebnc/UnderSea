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
using UnderSea.Dal.Data;
using UnderSea.Model.Models;

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
            
            if (registerDto.Password != registerDto.ConfirmPassword)
                throw new Exception();

            var result = await _userManager.CreateAsync(user, registerDto.Password);
            return result.Succeeded;
        }

        public async Task<PagedResult<UserRankDto>> GetRanklist(PaginationData pagination, string nameFilter)
        {
            var users = _context.Users
                .OrderByDescending(u => u.Points)
                .ProjectTo<UserRankDto>(_mapper.ConfigurationProvider);

            if (!string.IsNullOrEmpty(nameFilter) && !string.IsNullOrWhiteSpace(nameFilter))
            {
                users = users.Where(u => u.Name.Contains(nameFilter));
            }

            return await users.ToPagedList(pagination.PageSize, pagination.PageNumber);
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
                Placement = (await _context.Users.OrderByDescending(u => u.Points).ToListAsync()).FindIndex(0, u => u.Id == user.Id)
            };
            
        }

        public async Task<CountryDetailsDto> GetUserDetails()
        {
            var country = await _context.Countries
                .Where(u => u.OwnerId == _identityService.GetCurrentUserId())
                .Include(c => c.CountryBuildings)
                    .ThenInclude(cb => cb.Building)
                .Include(c => c.CountryUnits)
                    .ThenInclude(cu => cu.Unit)
                .FirstOrDefaultAsync();

            var buildings = await _context.Buildings
                                .Include(b => b.ActiveConstructions).ToListAsync();

            return new CountryDetailsDto
            {
                MaxUnitCount = country.MaxUnitCount,
                Units = _mapper.Map<ICollection<BattleUnitDto>>(country.CountryUnits.Select(cu => cu.Unit)),
                Coral = country.Coral,
                Pearl = country.Pearl,
                CurrentCoralProduction = (int)(country.Production.BaseCoralProduction * country.Production.CoralProductionMultiplier),
                CurrentPearlProduction = (int)(country.Production.BasePearlProduction * country.Production.PearlProductionMultiplier),
                Buildings = buildings.Select(building =>
                {
                    return new BuildingInfoDto
                    {
                        Id = building.Id,
                        Name = building.Name,
                        BuildingsCount = country.CountryBuildings.Where(cb => cb.BuildingId == building.Id).Count(),
                        ActiveConstructionCount = country.ActiveConstructions.Where(ac => ac.BuildingId == building.Id).Count()
                    };
                })
                /*Buildings = country.CountryBuildings.Select(cb => cb.Building).Select(building =>
                {
                    return new BuildingInfoDto
                    {
                        Id = building.Id,
                        Name = building.Name,
                        BuildingsCount = country.CountryBuildings.Where(cb => cb.BuildingId == building.Id).Count(),
                        ActiveConstructionCount = country.ActiveConstructions.Where(ac => ac.BuildingId == building.Id).Count()
                    };
                })*/
            };
        }

        public async Task<string> GetUserCountryName()
        {
            return (await _context.Countries
                            .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                            .FirstOrDefaultAsync()
                    ).Name;
        }

        public async Task ChangeCountryName(string name)
        {
            if (string.IsNullOrEmpty(name) || string.IsNullOrWhiteSpace(name))
                throw new Exception();

            var country = await _context.Countries
                                    .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                                    .FirstOrDefaultAsync();
            country.Name = name.Trim();
            await _context.SaveChangesAsync();
        }
    }
}
