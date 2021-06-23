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
        public int BaseCoralProduction { get; set; }
        public int BasePearlProduction { get; set; }
        public int CurrentCoralProduction { get; set; }
        public int CurrentPearlProduction { get; set; }
    }
}
