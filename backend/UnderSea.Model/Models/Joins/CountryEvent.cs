using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models.Joins
{
    public class CountryEvent
    {
        public int Id { get; set; }
        public int CountryId { get; set; }
        public Country Country { get; set; }
        public int EventId { get; set; }
        public Event Event { get; set; }
        public int EventRound { get; set; }
    }
}
