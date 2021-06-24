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
        public double AttackPointMultiplier { get; set; }
        public double DefensePointMultiplier { get; set; }
    }
}
