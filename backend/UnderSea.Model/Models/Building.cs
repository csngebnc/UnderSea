using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class Building
    {
        public int Id { get; set; }
        [Range(0, int.MaxValue, ErrorMessage = "Az épület ára nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az épület árát kötelező megadni!")]
        public int Price { get; set; }
        [Range(0, int.MaxValue, ErrorMessage = "Az építési idő nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az építési időt kötelező megadni!")]
        public int ConstructionTime { get; set; }

        public ICollection<CountryBuilding> CountryBuildings { get; set; }
    }
}
