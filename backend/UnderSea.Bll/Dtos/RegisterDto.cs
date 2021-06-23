using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class RegisterDto
    {
        [Required(ErrorMessage = "A felhasználónév megadása kötelező!")]
        [StringLength(30, ErrorMessage = "A felhasználónév legfeljebb 30 karakter lehet.")]
        public string UserName { get; set; }
        [Required(ErrorMessage = "Jelszó megadása kötelező!")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        [Required(ErrorMessage = "Jelszó megadása kötelező!")]
        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage = "A megadott jelszavak nem egyeznek.")]
        public string ConfirmPassword { get; set; }
        [Required(ErrorMessage = "Az országnév megadása kötelező.")]
        public string CountryName { get; set; }

    }
}
