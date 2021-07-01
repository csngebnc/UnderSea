using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class BuyUnitDetailsDto
    {
        [Required(ErrorMessage = "Az egység azonosítóját kötelező megadni!")]
        public int UnitId { get; set; }
        [Range(0, int.MaxValue, ErrorMessage = "Az egység darabszáma nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az egységből vásárolt darabszámot kötelező megadni!")]
        public int Count { get; set; }
    }
}
