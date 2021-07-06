using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos.Material;

namespace UnderSea.Bll.Dtos
{
    public class BuildingDetailsDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Count { get; set; }
        public ICollection<MaterialDto> RequiredMaterials { get; set; }
        public bool UnderConstruction { get; set; }
        public string ImageUrl { get; set; }
        public ICollection<EffectDto> Effects { get; set; }
    }
}
