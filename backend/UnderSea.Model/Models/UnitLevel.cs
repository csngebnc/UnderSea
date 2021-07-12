using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class UnitLevel
    {
        public int UnitId { get; set; }
        public Unit Unit { get; set; }
        public int MinimumBattles { get; set; }
        public int AttackPoint { get; set; }
        public int DefensePoint { get; set; }
        public int Level { get; set; }
    }
}
