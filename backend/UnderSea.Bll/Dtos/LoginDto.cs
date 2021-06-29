using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class LoginDto
    {
        [Required(ErrorMessage = "A felhasználónév megadása kötelező!")]
        [StringLength(30, ErrorMessage = "A felhasználónév legfeljebb 30 karakter lehet.")]
        public string UserName { get; set; }
        [Required(ErrorMessage = "Jelszó megadása kötelező!")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
    }
}
