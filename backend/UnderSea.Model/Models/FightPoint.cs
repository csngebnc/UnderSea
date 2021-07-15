using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class FightPoint
    {
        public double BonusAttackPoint { get; set; } = 0.0;
        public double AttackPointMultiplier { get; set; } = 1;
        public double DefensePointMultiplier { get; set; } = 1;
    }
}
