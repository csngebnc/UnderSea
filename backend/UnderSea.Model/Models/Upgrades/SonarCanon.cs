using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models
{
    public class SonarCanon : Upgrade
    {
        public override void ApplyUpgrade(Country country)
        {
            var units = country.CountryUnits;
            foreach (var u in units)
            {
                u.BonusAttackPoint = (int)Math.Round(u.BonusAttackPoint + u.Unit.AttackPoint * UpgradeConstants.SonarCanon);
            }
        }

        public override void RemoveUpgrade(Country country)
        {
            var units = country.CountryUnits;
            foreach (var u in units)
            {
                u.BonusAttackPoint = (int)Math.Round(u.BonusAttackPoint - u.Unit.AttackPoint * UpgradeConstants.SonarCanon);
            }
        }
    }
}
