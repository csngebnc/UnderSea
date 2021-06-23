using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models
{
    public class CoralEffect : Effect
    {
        public override void Affect(Country country)
        {
            country.Production.BaseCoralProduction += EffectConstants.CoralNumber;
        }
    }
}
