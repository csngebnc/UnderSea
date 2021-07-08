using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos.Material;
using UnderSea.Bll.Dtos.Unit;

namespace UnderSea.Bll.Dtos
{
    public class UnitDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public ICollection<UnitLevelDto> UnitLevels { get; set; }
        public int MercenaryPerRound { get; set; }
        public int SupplyPerRound { get; set; }
        public ICollection<MaterialDto> RequiredMaterials { get; set; }
        public int CurrentCount { get; set; }
        public string ImageUrl { get; set; }
    }
}
