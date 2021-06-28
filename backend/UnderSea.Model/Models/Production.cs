using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    [Owned]
    public class Production
    {
        public int BaseCoralProduction { get; set; } = 0;
        public int BasePearlProduction { get; set; } = 200;
        public double CoralProductionMultiplier { get; set; } = 1;
        public double PearlProductionMultiplier { get; set; } = 1;
    }
}
