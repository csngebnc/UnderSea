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
using UnderSea.Bll.Validation;
using UnderSea.Bll.Validation.Exceptions;
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
            var validator = new RegisterValidation(_context);
            await validator.ValidateAsync(registerDto);

            var user = new User { UserName = registerDto.UserName.Trim() };
            
            var result = await _userManager.CreateAsync(user, registerDto.Password);
            
            var country = new Country { Name = registerDto.CountryName, OwnerId = user.Id, WorldId = (await _context.Worlds.OrderByDescending(w => w.Id).FirstOrDefaultAsync()).Id };
            _context.Countries.Add(country);
            await _context.SaveChangesAsync();
            return result.Succeeded;
        }

        public async Task<PagedResult<UserRankDto>> GetRanklist(PaginationData pagination, string nameFilter)
        {
            var validator = new PaginationDataValidator();
            validator.Validate(pagination);

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

            if (user == null)
                throw new NotExistsException("Nem létezik ilyen felhasználó.");

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
            var userid = _identityService.GetCurrentUserId();

            if (userid == null)
                throw new NotExistsException("Nem létezik ilyen felhasználó.");

            var country = await _context.Countries
                .Where(u => u.OwnerId == userid)
                .Include(c => c.ActiveConstructions)
                .Include(c => c.CountryBuildings)
                    .ThenInclude(cb => cb.Building)
                .Include(c => c.CountryUnits)
                    .ThenInclude(cu => cu.Unit)
                .FirstOrDefaultAsync();

            if (country == null)
                throw new NotExistsException("Nem létezik ilyen ország.");

            var buildings = await _context.Buildings
                                .Include(b => b.ActiveConstructions).ToListAsync();

            return new CountryDetailsDto
            {
                MaxUnitCount = country.MaxUnitCount,
                Units = _mapper.Map<ICollection<BattleUnitDto>>(country.CountryUnits.Select(cu => cu.Unit)),
                Coral = country.Coral,
                Pearl = country.Pearl,
                Population = country.Population,
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
            };
        }

        public async Task<string> GetUserCountryName()
        {
            return (await _context.Countries
                            .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                            .FirstOrDefaultAsync()
                    )?.Name;
        }

        public async Task ChangeCountryName(string name)
        {
            if (string.IsNullOrEmpty(name) || string.IsNullOrWhiteSpace(name))
                throw new InvalidParameterException("Az ország nevének megadása kötelező.");

            var country = await _context.Countries
                                    .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                                    .FirstOrDefaultAsync();
            if (country == null)
                throw new NotExistsException("Nem létezik ilyen ország.");

            country.Name = name.Trim();
            await _context.SaveChangesAsync();
        }
    }
}
