using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos.Material;

namespace UnderSea.Bll.Dtos
{
    public class UnitDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int AttackPoint { get; set; }
        public int DefensePoint { get; set; }
        public int MercenaryPerRound { get; set; }
        public int SupplyPerRound { get; set; }
        public ICollection<MaterialDto> RequiredMaterials { get; set; }
        public int CurrentCount { get; set; }
        public string ImageUrl { get; set; }
    }
}
