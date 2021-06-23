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
            var units = country.CountryUnits;
            foreach (var u in units)
            {
                u.BonusAttackPoint = (int)Math.Round(u.BonusAttackPoint + u.Unit.AttackPoint * UpgradeConstants.UnderWaterMartialArt);
                u.BonusDefensePoint = (int)Math.Round(u.BonusDefensePoint + u.Unit.DefensePoint * UpgradeConstants.UnderWaterMartialArt);
            }
        }

        public override void RemoveEffect(Country country)
        {
            var units = country.CountryUnits;
            foreach (var u in units)
            {
                u.BonusAttackPoint = (int)Math.Round(u.BonusAttackPoint - u.Unit.AttackPoint * UpgradeConstants.UnderWaterMartialArt);
                u.BonusDefensePoint = (int)Math.Round(u.BonusDefensePoint - u.Unit.DefensePoint * UpgradeConstants.UnderWaterMartialArt);
            }
        }
    }
}
