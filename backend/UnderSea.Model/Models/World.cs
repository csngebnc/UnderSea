using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class World
    {
        public int Id { get; set; }
        public int Round { get; set; }

        public ICollection<Country> Countries { get; set; }
    }
}
