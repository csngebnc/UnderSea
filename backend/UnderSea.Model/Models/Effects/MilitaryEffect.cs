using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models
{
    public class MilitaryEffect : Effect
    {
        public override void ApplyEffect(Country country)
        {
            country.UnitCount += EffectConstants.SoldierNumber;
        }
    }
}
