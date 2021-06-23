using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class AttackUnit
    {
        public int Id { get; set; }
        [Range(0, int.MaxValue, ErrorMessage = "A támadó egység száma nem lehet negatív szám!")]
        [Required(ErrorMessage = "A támadó egység számát kötelező megadni!")]
        public int Count { get; set; }

        public int AttackId { get; set; }
        public Attack Attack { get; set; }

        public int UnitId { get; set; }
        public Unit Unit { get; set; }
    }
}
