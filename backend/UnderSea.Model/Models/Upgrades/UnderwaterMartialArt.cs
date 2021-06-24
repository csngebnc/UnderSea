using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models
{
    public class UnderwaterMartialArt : Effect
    {
        public override void ApplyEffect(Country country)
        {
            country.FightPoint.AttackPointMultiplier *= (1 + UpgradeConstants.UnderWaterMartialArt);
            country.FightPoint.DefensePointMultiplier *= (1 + UpgradeConstants.UnderWaterMartialArt);
        }

        public override void RemoveEffect(Country country)
        {
            country.FightPoint.AttackPointMultiplier /= (1 + UpgradeConstants.UnderWaterMartialArt);
            country.FightPoint.DefensePointMultiplier /= (1 + UpgradeConstants.UnderWaterMartialArt);
        }
    }
}
