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
            var units = country.CountryUnits;
            foreach(var u in units)
            {
                u.BonusDefensePoint = (int)Math.Round(u.BonusDefensePoint + u.Unit.DefensePoint * UpgradeConstants.CoralWall);
            }
        }

        public override void RemoveEffect(Country country)
        {
            var units = country.CountryUnits;
            foreach (var u in units)
            {
                u.BonusDefensePoint = (int)Math.Round(u.BonusDefensePoint - u.Unit.DefensePoint * UpgradeConstants.CoralWall);
            }
        }
    }
}
