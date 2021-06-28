using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class CountryUnit
    {
        [Range(0, int.MaxValue, ErrorMessage = "Az ország egységének mennyisége nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az ország egységének mennyiségét kötelező megadni!")]
        public int Count { get; set; }

        public int CountryId { get; set; }
        public Country Country { get; set; }

        public int UnitId { get; set; }
        public Unit Unit { get; set; }

    }
}
