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
        [Range(0, int.MaxValue, ErrorMessage = "A pont nem lehet negatív szám!")]
        [Required(ErrorMessage = "A pontot kötelező megadni!")]
        public int Points { get; set; }
    }
}
