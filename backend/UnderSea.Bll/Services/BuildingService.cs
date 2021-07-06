using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Bll.Validation.Exceptions;
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

            if (country == null)
            {
                throw new NotExistsException("Nem létezik ilyen ország.");
            }
                

            var buildings = await _context.Buildings
                                        .Include(b => b.BuildingEffects)
                                            .ThenInclude(be => be.Effect)
                                        .Include(b => b.BuildingMaterials)
                                            .ThenInclude(bm => bm.Material)
                                        .ToListAsync();

            return buildings.Select(building =>
            {
                var countryBuilding = country.CountryBuildings.Where(cb => cb.BuildingId == building.Id).SingleOrDefault();
                return new BuildingDetailsDto
                {
                    Id = building.Id,
                    Name = building.Name,
                    Effects = _mapper.Map<ICollection<EffectDto>>(building.BuildingEffects.Select(be => be.Effect)),
                    RequiredMaterials = building.BuildingMaterials.Select(bm =>
                    {
                        return new Dtos.Material.MaterialDto
                        {
                            Id = bm.MaterialId,
                            Name = bm.Material.Name,
                            Amount = bm.Amount,
                            ImageUrl = bm.Material.ImageUrl
                        };
                    }).ToList(),
                    Count = countryBuilding != null ? countryBuilding.Count : 0,
                    UnderConstruction = country.ActiveConstructions.Any(ac => ac.BuildingId == building.Id),
                    ImageUrl = building.ImageUrl
                };
            });
        }

        public async Task BuyBuildingAsync(BuyBuildingDto buildingDto)
        {
            var country = await _context.Countries
                                    .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                                    .Include(c => c.World)
                                    .Include(c => c.CountryMaterials)
                                    .FirstOrDefaultAsync();

            if (country == null)
            {
                throw new NotExistsException("Nem létezik ilyen ország.");
            }

            var building = await _context.Buildings
                .Where(b => b.Id == buildingDto.BuildingId)
                .Include(b => b.BuildingMaterials)
                    .ThenInclude(bm => bm.Material)
                .FirstOrDefaultAsync();

            if (building == null)
            {
                throw new NotExistsException("Nem létezik ilyen épület.");
            }

            var activebuilding = await _context.ActiveConstructions.FirstOrDefaultAsync(ac => ac.CountryId == country.Id);
            if (activebuilding != null)
            {
                throw new InvalidParameterException("Már folyamatban van egy építés.");
            }


                var activeConstruction = new ActiveConstruction()
                {
                    BuildingId = building.Id,
                    CountryId = country.Id,
                    EstimatedFinish = country.World.Round + building.ConstructionTime
                };
                _context.ActiveConstructions.Add(activeConstruction);

                foreach (var materialRequirement in building.BuildingMaterials)
                {
                    country.CountryMaterials.SingleOrDefault(cm => cm.MaterialId == materialRequirement.MaterialId).Amount -= materialRequirement.Amount;
                }

            await _context.SaveChangesAsync();
        }
    }
}
