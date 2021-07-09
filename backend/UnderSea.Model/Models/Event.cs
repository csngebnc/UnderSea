using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Models.Joins;

namespace UnderSea.Model.Models
{
    public class Event
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public ICollection<EventEffect> EventEffects { get; set; }
        public ICollection<CountryEvent> CountryEvents { get; set; }
    }
}
