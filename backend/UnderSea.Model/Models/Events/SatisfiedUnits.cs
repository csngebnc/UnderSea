using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models.Events
{
    public class SatisfiedUnits : Effect
    {
        public override void ApplyEffect(Country country)
        {
            country.FightPoint.BonusAttackPoint += 1;
        }

        public override void RemoveEffect(Country country)
        {
            country.FightPoint.BonusAttackPoint += 1;
        }
    }
}
