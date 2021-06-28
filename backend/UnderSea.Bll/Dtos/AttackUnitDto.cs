using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class AttackUnitDto
    {

        [Required(ErrorMessage = "Az egység azonosítójának megadása kötelező!")]
        public int UnitId { get; set; }
        [Required(ErrorMessage = "Az egység darabszámának megadása kötelező!")]
        public int Count { get; set; }
    }
}
