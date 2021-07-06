using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Bll.Validation.Exceptions;
using UnderSea.Dal.Data;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services
{
    public class CountryService : ICountryService
    {
        private readonly IIdentityService _identityService;
        private readonly IMapper _mapper;
        private readonly UnderSeaDbContext _context;

        public CountryService(UnderSeaDbContext context, IMapper mapper, IIdentityService identityService)
        {
            _context = context;
            _mapper = mapper;
            _identityService = identityService;
        }

        public async Task<CountryDetailsDto> GetUserCountryDetails()
        {
            var userid = _identityService.GetCurrentUserId();

            var country = await _context.Countries
                .Where(u => u.OwnerId == userid)
                .Include(c => c.CountryMaterials)
                    .ThenInclude(cm => cm.Material)
                .Include(c => c.ActiveConstructions)
                .Include(c => c.CountryBuildings)
                    .ThenInclude(cb => cb.Building)
                .Include(c => c.CountryUnits)
                    .ThenInclude(cu => cu.Unit)
                .Include(c => c.CountryUpgrades)
                    .ThenInclude(cu => cu.Upgrade)
                        .ThenInclude(u => u.UpgradeEffects)
                            .ThenInclude(ue => ue.Effect)
                .FirstOrDefaultAsync();

            if (country == null)
            {
                throw new NotExistsException("Nem létezik ilyen ország.");
            }

            var buildings = await _context.Buildings
                                .Include(b => b.ActiveConstructions)
                                .ToListAsync();

            var units = await _context.Units.ToListAsync();

            var effects = country.CountryUpgrades
                .Select(cu => cu.Upgrade)
                .SelectMany(upgrade => upgrade.UpgradeEffects)
                .Select(effect => effect.Effect);

            var hasSonarCanon = effects.Any(e => e.EffectType == "upgrade_effect_sonarcannon");

            return new CountryDetailsDto
            {
                MaxUnitCount = country.MaxUnitCount,
                Units = _mapper.Map<ICollection<BattleUnitDto>>(units),
                Population = country.Population,
                HasSonarCanon = hasSonarCanon,
                Materials = country.CountryMaterials.Select(cm =>
                {
                    return new Dtos.Material.MaterialDetailsDto
                    {
                        Id = cm.MaterialId,
                        Name = cm.Material.Name,
                        Production = (int)(cm.BaseProduction * cm.Multiplier),
                        Amount = cm.Amount,
                        ImageUrl = cm.Material.ImageUrl
                    };
                }).ToList(),
                Buildings = buildings.Select(building =>
                {
                    var countryBuilding = country.CountryBuildings.SingleOrDefault(cb => cb.BuildingId == building.Id);
                    var activeBuildingCount = country.ActiveConstructions.Count(ac => ac.BuildingId == building.Id);

                    return new BuildingInfoDto
                    {
                        Id = building.Id,
                        Name = building.Name,
                        BuildingsCount = countryBuilding == null ? 0 : countryBuilding.Count,
                        ActiveConstructionCount = activeBuildingCount,
                        IconImageUrl = building.IconImageUrl
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

        public async Task ChangeUserCountryName(string name)
        {
            if (string.IsNullOrEmpty(name) || string.IsNullOrWhiteSpace(name))
            {
                throw new InvalidParameterException("country", "Az ország nevének megadása kötelező.");
            }

            var country = await _context.Countries
                                    .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                                    .FirstOrDefaultAsync();
            if (country == null)
            {
                throw new NotExistsException("Nem létezik ilyen ország.");
            }

            country.Name = name.Trim();
            await _context.SaveChangesAsync();
        }

    }
}
