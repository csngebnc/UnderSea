using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Enums;

namespace UnderSea.Bll.Dtos.Spy
{
    public class SpyReportDto
    {
        public int SpyReportId { get; set; }
        public string SpiedCountryName { get; set; }
        public FightOutcome OutCome { get; set; }
        public int? DefensePoints { get; set; }
    }
}
