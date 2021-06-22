using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class CountryUpgrade
    {
        [Range(0, int.MaxValue, ErrorMessage = "A fejlesztés befejezése nem lehet negatív szám!")]
        [Required(ErrorMessage = "A fejlesztés befejezésének idejét kötelező megadni!")]
        public int EstimatedFinish { get; set; }

        public int CountryId { get; set; }
        public Country Country { get; set; }

        public int UpgradeId { get; set; }
        public Upgrade Upgrade { get; set; }
    }
}
