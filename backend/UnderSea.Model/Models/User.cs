using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class User : IdentityUser
    {
        public int Points { get; set; }

        public Country Country { get; set; }
        public ICollection<Attack> AttackWins { get; set; }

    }
}
