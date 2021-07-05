using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models.Joins
{
    public class CountryMaterial
    {
        public int CountryId { get; set; }
        public Country Country { get; set; }
        public int MaterialId { get; set; }
        public Material Material { get; set; }

        public int BaseProduction { get; set; }
        public decimal Multiplier { get; set; }
    }
}
