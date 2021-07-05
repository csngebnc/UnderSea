using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Models.Materials;

namespace UnderSea.Model.Models.Joins
{
    public class BuildingMaterial
    {
        public int BuildingId { get; set; }
        public int MaterialId { get; set; }
        public int Amount { get; set; }

        public Building Building { get; set; }
        public Material Material { get; set; }
    }
}
