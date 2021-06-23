using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models
{
    public class MudCombine : Upgrade 
    {
        public override void ApplyUpgrade(Country country)
        {
            country.Production.CurrentCoralProduction = (int)Math.Round(country.Production.BaseCoralProduction * UpgradeConstants.MudCombine + country.Production.CurrentCoralProduction);
        }

        public override void RemoveUpgrade(Country country)
        {
            country.Production.CurrentCoralProduction = (int)Math.Round(country.Production.CurrentCoralProduction - country.Production.BaseCoralProduction * UpgradeConstants.MudCombine);
        }
    }
}
