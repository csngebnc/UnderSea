using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models
{
    public class Alchemy : Upgrade
    {
        public override void ApplyUpgrade(Country country)
        {
            country.Production.CurrentPearlProduction = (int)Math.Round(country.Production.BasePearlProduction * UpgradeConstants.Alchemy + country.Production.CurrentPearlProduction);
        }

        public override void RemoveUpgrade(Country country)
        {
            country.Production.CurrentPearlProduction = (int)Math.Round(country.Production.CurrentPearlProduction - country.Production.BasePearlProduction * UpgradeConstants.Alchemy);
        }
    }
}
