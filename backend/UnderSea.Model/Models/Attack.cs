using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class Attack
    {
        public int Id { get; set; }
        [Range(0, int.MaxValue, ErrorMessage = "A támadás köre nem lehet negatív szám!")]
        [Required(ErrorMessage = "A támadás körét kötelező megadni!")]
        public int AttackRound { get; set; }

        public string WinnerId { get; set; }
        public User Winner { get; set; }

        public int AttackerCountryId { get; set; }
        public Country AttackerCountry { get; set; }

        public int DefenderCountryId { get; set; }
        public Country DefenderCountry { get; set; }
    }
}
