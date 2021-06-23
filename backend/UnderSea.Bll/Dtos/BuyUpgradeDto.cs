using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class BuyUpgradeDto
    {
        [Required(ErrorMessage = "A fejlesztés azonosítójának megadása kötelező!")]
        public int UpgradeId { get; set; }
    }
}
