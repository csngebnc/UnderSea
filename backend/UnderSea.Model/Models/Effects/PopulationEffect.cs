using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models
{
    public class PopulationEffect : Effect
    {
        public override void ApplyEffect(Country country)
        {
            country.Population += EffectConstants.PopulationNumber;
        }

        public override void RemoveEffect(Country country)
        {
            country.Population += EffectConstants.PopulationNumber;
        }
    }
}
