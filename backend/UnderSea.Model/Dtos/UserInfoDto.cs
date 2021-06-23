using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Dtos
{
    public class UserInfoDto
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public int Round { get; set; }
        public int Placement { get; set; }
    }
}
