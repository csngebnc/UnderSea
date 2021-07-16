using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models.Events
{
    public class UnsatisfiedPeople : Effect
    {
        public override void ApplyEffect(Country country)
        {
            if (country.CountryBuildings.Any(cb => cb.Building.Name == BuildingNameConstants.Aramlasiranyito))
            {
                var cb = country.CountryBuildings.SingleOrDefault(cb => cb.Building.Name == BuildingNameConstants.Aramlasiranyito);
                if(cb.Count > 0)
                {
                    cb.Count -= 1;
                    foreach (var be in cb.Building.BuildingEffects)
                    {
                        be.Effect.RemoveEffect(country);
                    }
                }
            }
        }

        public override void RemoveEffect(Country country) { }
    }
}
