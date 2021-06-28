using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services
{
    public class BuildingService : IBuildingService
    {
        private readonly UnderSeaDbContext _context;
        private readonly IIdentityService _identityService;
        private readonly IMapper _mapper;

        public BuildingService(UnderSeaDbContext context, IMapper mapper, IIdentityService identityService)
        {
            _context = context;
            _mapper = mapper;
            _identityService = identityService;
        }

        public async Task<IEnumerable<BuildingDetailsDto>> GetUserBuildingAsync()
        {
            var country = await _context.Countries
                                    .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                                    .Include(c => c.CountryBuildings)
                                    .Include(c => c.ActiveConstructions)
                                    .FirstOrDefaultAsync();

            var buildings = await _context.Buildings
                                        .Include(b => b.BuildingEffects)
                                        .ThenInclude(be => be.Effect)
                                        .ToListAsync();

            return buildings.Select(building =>
            {
                return new BuildingDetailsDto
                {
                    Id = building.Id,
                    Name = building.Name,
                    Effects = _mapper.Map<ICollection<EffectDto>>(building.BuildingEffects.Select(be => be.Effect)),
                    Price = building.Price,
                    Count = country.CountryBuildings.Where(cb => cb.BuildingId == building.Id).Count(),
                    UnderConstruction = country.ActiveConstructions.Any(ac => ac.BuildingId == building.Id)
                };
            });
        }

        public async Task BuyBuildingAsync(BuyBuildingDto buildingDto)
        {
            var country = await _context.Countries
                                    .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                                    .Include("World")
                                    .FirstOrDefaultAsync();

            var building = await _context.Buildings.Where(c => c.Id == buildingDto.BuildingId).FirstOrDefaultAsync();
            if (building == null) throw new NullReferenceException();

            var activebuilding = await _context.ActiveConstructions.Where(ac => ac.CountryId == country.Id).FirstOrDefaultAsync();
            if (activebuilding != null) throw new InvalidOperationException();

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
    }
}
