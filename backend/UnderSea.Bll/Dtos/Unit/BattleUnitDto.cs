using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class BattleUnitDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Count { get; set; }
        public string ImageUrl { get; set; }
    }
}
