using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class AttackableUserDto
    {
        public string Id { get; set; }
        public string UserName { get; set; }
        public int CountryId { get; set; }
    }
}
