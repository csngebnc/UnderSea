using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class ActiveUpgrading
    {
        public int Id { get; set; }
        public int CountryId { get; set; }
        public Country Country { get; set; }
        public int UpgradeId { get; set; }
        public Upgrade Upgrade { get; set; }
        public int EstimatedFinish { get; set; }
    }
}
