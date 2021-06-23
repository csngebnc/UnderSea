using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class BuildingInfoDto
    {
        public int Id { get; set; }

        [StringLength(50, ErrorMessage = "Az épület neve maximum 50 karakter lehet!")]
        [Required(ErrorMessage = "Az épület nevét kötelező megadni!")]
        public string Name { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Az épületek száma nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az épületek számát kötelező megadni!")]
        public int BuildingsCount { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Az épületek száma nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az épületek számát kötelező megadni!")]
        public int ActiveConstructionCount { get; set; }
    }
}
