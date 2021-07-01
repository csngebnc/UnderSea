using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class Upgrade
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int UpgradeTime { get; set; }
        public string ImageUrl { get; set; }

        public ICollection<CountryUpgrade> CountryUpgrades { get; set; }
        public ICollection<UpgradeEffect> UpgradeEffects { get; set; }
        public ICollection<ActiveUpgrading> ActiveUpgradings { get; set; }

    }
}
