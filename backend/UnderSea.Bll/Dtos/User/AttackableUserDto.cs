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
        [Required(ErrorMessage = "A felhasználó azonosítójának megadása kötelező!")]
        public string Id { get; set; }
        [Required(ErrorMessage = "A felhasználó nevének megadása kötelező!")]
        public string UserName { get; set; }
        [Required(ErrorMessage = "A város azonosítójának megadása kötelező!")]
        public int CountryId { get; set; }
    }
}
