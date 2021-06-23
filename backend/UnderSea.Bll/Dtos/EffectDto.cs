using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class EffectDto
    {
        [Required(ErrorMessage = "Az egység azonosítóját kötelező megadni!")]
        public int Id { get; set; }

        [Required(ErrorMessage = "A hatás nevét kötelező megadni!")]
        [StringLength(100, ErrorMessage = "A hatás neve maximum 100 karakter hosszú lehet!")]
        public string Name { get; set; }
    }
}
