using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos.Unit
{
    public class BuyUnitDto
    {
        [Required(ErrorMessage = "Egységek megadása kötelező")]
        public ICollection<BuyUnitDetailsDto> Units { get; set; }
    }
}
