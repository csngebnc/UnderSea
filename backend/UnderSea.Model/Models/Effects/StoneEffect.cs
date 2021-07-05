using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models.Effects
{
    public class StoneEffect : Effect
    {
        public override void ApplyEffect(Country country)
        {
            country.CountryMaterials.SingleOrDefault(cm => cm.Material.MaterialType == MaterialTypeConstants.Stone).Amount += EffectConstants.StoneNumber;
        }

        public override void RemoveEffect(Country country)
        {
            country.CountryMaterials.SingleOrDefault(cm => cm.Material.MaterialType == MaterialTypeConstants.Stone).Amount -= EffectConstants.StoneNumber;
        }
    }
}
