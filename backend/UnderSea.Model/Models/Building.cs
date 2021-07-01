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

        [StringLength(50, ErrorMessage = "Az épület neve maximum 50 karakter lehet!")]
        [Required(ErrorMessage = "Az épület nevét kötelező megadni!")]
        public string Name { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Az épület ára nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az épület árát kötelező megadni!")]
        public int Price { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Az építési idő nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az építési időt kötelező megadni!")]
        public int ConstructionTime { get; set; }

        public ICollection<CountryBuilding> CountryBuildings { get; set; }
        public ICollection<BuildingEffect> BuildingEffects { get; set; }
        public ICollection<ActiveConstruction> ActiveConstructions { get; set; }
    }
}
