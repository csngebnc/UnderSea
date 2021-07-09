using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models.Events
{
    public class GoodHarvest : Effect
    {
        public override void ApplyEffect(Country country)
        {
            country.CountryMaterials.SingleOrDefault(m => m.Material.MaterialType == MaterialTypeConstants.Coral).BaseProduction = 250;
        }

        public override void RemoveEffect(Country country)
        {
            country.CountryMaterials.SingleOrDefault(m => m.Material.MaterialType == MaterialTypeConstants.Coral).BaseProduction = 200;
        }
    }
}
