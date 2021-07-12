using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos.Event
{
    public class EventDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int EventRound { get; set; }
        public ICollection<EffectDto> Effects { get; set; }
    }
}
