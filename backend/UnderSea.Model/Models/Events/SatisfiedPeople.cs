using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models.Events
{
    public class SatisfiedPeople : Effect
    {
        public override void ApplyEffect(Country country)
        {
            if (country.CountryBuildings.Any(cb => cb.BuildingId == 1))
            {
                var cb = country.CountryBuildings.SingleOrDefault(cb => cb.BuildingId == 1);
                cb.Count += 1;
                foreach (var be in cb.Building.BuildingEffects)
                {
                    be.Effect.ApplyEffect(country);
                }
            }
            else
            {
                var cb = new CountryBuilding
                {
                    BuildingId = 1,
                    Count = 1,
                    CountryId = country.Id
                };

                country.CountryBuildings.Add(cb);
                country.Population += 50;
                country.CountryMaterials.SingleOrDefault(cm => cm.Material.MaterialType == MaterialTypeConstants.Coral).BaseProduction += 200;

            }
        }

        public override void RemoveEffect(Country country) { }
    }
}
