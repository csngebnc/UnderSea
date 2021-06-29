using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class ActiveConstruction
    {
        public int Id { get; set; }
        [Range(0,int.MaxValue, ErrorMessage = "A befejezés nem lehet negatív szám!")]
        [Required(ErrorMessage = "A befejezés idejét kötelező megadni!")]
        public int EstimatedFinish { get; set; }

        public int CountryId { get; set; }
        public Country Country { get; set; }

        public int BuildingId { get; set; }
        public Building Building { get; set; }
    }
}
