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

        [Required(ErrorMessage = "A fejlesztés nevét kötelező megadni!")]
        [StringLength(100, ErrorMessage = "A fejlesztés neve maximum 100 karakter hosszú lehet!")]
        public string Name { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "A fejlesztési idő nem lehet negatív szám!")]
        [Required(ErrorMessage = "A fejlesztési időt kötelező megadni!")]
        public int UpgradeTime { get; set; }

        public ICollection<CountryUpgrade> CountryUpgrades { get; set; }
        public ICollection<UpgradeEffect> UpgradeEffects { get; set; }
        public ICollection<ActiveUpgrading> ActiveUpgradings { get; set; }

    }
}
