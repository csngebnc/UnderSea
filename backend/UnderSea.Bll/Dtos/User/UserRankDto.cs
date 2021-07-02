using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class UserRankDto
    {
        public string Name { get; set; }
        public int Points { get; set; }
        public int Placement { get; set; }
    }
}
