using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class Building
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Price { get; set; }
        public int ConstructionTime { get; set; }

        public ICollection<CountryBuilding> CountryBuildings { get; set; }
        public ICollection<BuildingEffect> BuildingEffects { get; set; }
        public ICollection<ActiveConstruction> ActiveConstructions { get; set; }
    }
}
