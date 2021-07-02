using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class BuildingInfoDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int BuildingsCount { get; set; }
        public int ActiveConstructionCount { get; set; }
        public string IconImageUrl { get; set; }
    }
}
