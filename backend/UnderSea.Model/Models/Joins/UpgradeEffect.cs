 using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class UpgradeEffect
    {
        public int UpgradeId { get; set; }
        public Upgrade Upgrade { get; set; }

        public int EffectId { get; set; }
        public Effect Effect { get; set; }
    }
}
