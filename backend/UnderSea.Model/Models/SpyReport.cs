using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class SpyReport
    {
        public int Id { get; set; }
        public int SpySenderCountryId { get; set; }
        public Country SpySenderCountry { get; set; }
        public int SpiedCountryId { get; set; }
        public Country SpiedCountry { get; set; }

        public int NumberOfSpies { get; set; }
        public int? DefensePoints { get; set; }

        public string WinnerId { get; set; }
        public User Winner { get; set; }

        public int Round { get; set; }
    }
}
