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
        public int UnitId { get; set; }
        public int Level { get; set; }
        public int Count { get; set; }
    }
}
