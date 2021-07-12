using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models.Joins
{
    public class EventEffect
    {
        public int EventId { get; set; }
        public Event Event { get; set; }
        public int EffectId { get; set; }
        public Effect Effect { get; set; }
    }
}
