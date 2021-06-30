using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class SendAttackDto
    {
        [Required(ErrorMessage = "A megtámadott ország azonosítójának megadása kötelező!")]
        public int AttackedCountryId { get; set; }
        [Required(ErrorMessage = "A támadáshoz szükség van egységek küldésére!")]
        public ICollection<AttackUnitDto> Units { get; set; }
    }
}
