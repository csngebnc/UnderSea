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
using UnderSea.Dal.Data;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services
{
    public class BuildingService
    {
        private readonly UnderSeaDbContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IMapper _mapper;

        public BuildingService(UnderSeaDbContext context, IHttpContextAccessor httpContextAccessor, IMapper mapper)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
            _mapper = mapper;
        }

        public async Task<IEnumerable<BuildingDetailsDto>> GetUserBuildingAsync()
        {
            var country = GetCountry();

            //var userbuildings = await _context.Buildings.Where(b => b.CountryBuildings.Where(cb => cb.CountryId == country.Id).Any()).ProjectTo<BuildingDetailsDto>(_mapper.ConfigurationProvider).ToListAsync();
            var userbuildings = await _context.CountryBuildings.Include(b => b.Building)
                                                                .Where(c => c.CountryId == country.Id)
                                                                .Select(b => b.Building)
                                                                .ProjectTo<BuildingDetailsDto>(_mapper.ConfigurationProvider)
                                                                .ToListAsync();
            return userbuildings;
        }

        public async Task BuyBuildingAsync(BuyBuildingDto buildingDto)
        {
            var country = await GetCountry();

            var building = await _context.Buildings.Where(c => c.Id == buildingDto.BuildingId).FirstOrDefaultAsync();
            if (building == null) throw new NullReferenceException();

            if (building.Price <= country.Pearl)
            {
                ActiveConstruction activeConstruction = new ActiveConstruction()
                {
                    BuildingId = building.Id,
                    CountryId = country.Id,
                    EstimatedFinish = country.World.Round + building.ConstructionTime
                };
                _context.ActiveConstructions.Add(activeConstruction);

                country.Pearl -= building.Price;
            }

            await _context.SaveChangesAsync();
        }

        private string GetUserId()
        {
            var userId = _httpContextAccessor.GetCurrentUserId();
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
