using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class UserRankDto
    {
        [Required(ErrorMessage = "A felhasználó nevét kötelező megadni!")]
        [StringLength(100, ErrorMessage = "A felhasználó neve maximum 100 karakter hosszú lehet!")]
        public string Name { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "A pont nem lehet negatív szám!")]
        [Required(ErrorMessage = "A pontot kötelező megadni!")]
        public int Points { get; set; }
    }
}
