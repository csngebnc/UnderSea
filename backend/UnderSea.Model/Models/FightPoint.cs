using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    [Owned]
    public class FightPoint
    {
        public int BonusAttackPoint { get; set; } = 0;
        public double AttackPointMultiplier { get; set; } = 1;
        public double DefensePointMultiplier { get; set; } = 1;
    }
}
