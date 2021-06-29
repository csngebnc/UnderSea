using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models
{
    public class CoralWall : Effect
    {
        public override void ApplyEffect(Country country)
        {
            country.FightPoint.DefensePointMultiplier *= (1 + UpgradeConstants.CoralWall);
        }

        public override void RemoveEffect(Country country)
        {
            country.FightPoint.DefensePointMultiplier /= (1 + UpgradeConstants.CoralWall);
        }
    }
}
