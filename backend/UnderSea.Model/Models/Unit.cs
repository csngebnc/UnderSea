using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Models.Joins;

namespace UnderSea.Model.Models
{
    public class Unit
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int AttackPoint { get; set; }
        public int DefensePoint { get; set; }
        public int MercenaryPerRound { get; set; }
        public int SupplyPerRound { get; set; }
        public ICollection<UnitMaterial> UnitMaterials { get; set; }
        public string ImageUrl { get; set; }

        public ICollection<CountryUnit> CountryUnits { get; set; }
    }
}
