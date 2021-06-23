using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class BuyBuildingDto
    {
        [Required(ErrorMessage = "Az épület azonosítójának megadása kötelező!")]
        public int BuildingId { get; set; }
    }
}
