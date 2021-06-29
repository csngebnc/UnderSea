using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class BuildingEffect
    {
        public int BuildingId { get; set; }
        public Building Building { get; set; }

        public int EffectId { get; set; }
        public Effect Effect { get; set; }

    }
}
