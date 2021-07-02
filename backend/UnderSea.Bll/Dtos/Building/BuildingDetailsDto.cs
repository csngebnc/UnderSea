using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class BuildingDetailsDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Count { get; set; }
        public int Price { get; set; }
        public bool UnderConstruction { get; set; }
        public string ImageUrl { get; set; }
        public ICollection<EffectDto> Effects { get; set; }
    }
}
