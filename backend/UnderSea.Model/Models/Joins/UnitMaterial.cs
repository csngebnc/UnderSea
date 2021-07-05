using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models.Joins
{
    public class UnitMaterial
    {
        public int UnitId { get; set; }
        public Unit Unit { get; set; }
        public int MaterialId { get; set; }
        public Material Material { get; set; }
        public int Amount { get; set; }
    }
}
