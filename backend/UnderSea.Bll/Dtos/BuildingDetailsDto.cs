using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class BuildingDetailsDto
    {
        [Required(ErrorMessage = "Az épület azonosítójának megadása kötelező.")]
        public int Id { get; set; }

        [StringLength(50, ErrorMessage = "Az épület neve maximum 50 karakter lehet!")]
        [Required(ErrorMessage = "Az épület nevét kötelező megadni!")]
        public string Name { get; set; }

        public ICollection<EffectDto> Effects { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Az épület darabszáma nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az épület darabszámát kötelező megadni!")]
        public int Count { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Az épület ára nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az épület árát kötelező megadni!")]
        public int Price { get; set; }
    }
}
