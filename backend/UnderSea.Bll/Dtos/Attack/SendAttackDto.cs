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
        public int AttackedCountryId { get; set; }
        public ICollection<AttackUnitDto> Units { get; set; }
    }
}
