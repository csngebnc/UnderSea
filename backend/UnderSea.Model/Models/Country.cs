using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Models.Joins;

namespace UnderSea.Model.Models
{
    public class Country
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Population { get; set; } = 100;
        public int Pearl { get; set; } = 1000;
        public int Coral { get; set; }
        public int MaxUnitCount { get; set; }

        public FightPoint FightPoint { get; set; } //= new FightPoint();

        public string OwnerId { get; set; }
        public User Owner { get; set; }

        public int WorldId { get; set; }
        public World World { get; set; }

        public ICollection<CountryMaterial> CountryMaterials { get; set; }
        public ICollection<Attack> Attacks { get; set; }
        public ICollection<Attack> Defenses { get; set; }
        public ICollection<SpyReport> SentSpies { get; set; }
        public ICollection<CountryUnit> CountryUnits { get; set; }
        public ICollection<CountryBuilding> CountryBuildings { get; set; }
        public ICollection<CountryUpgrade> CountryUpgrades { get; set; }
        public ICollection<ActiveUpgrading> ActiveUpgradings { get; set; }
        public ICollection<ActiveConstruction> ActiveConstructions { get; set; }
    }
}
