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
        public int AttackRound { get; set; }
        public string WinnerId { get; set; }
        public User Winner { get; set; }

        public int AttackerCountryId { get; set; }
        public Country AttackerCountry { get; set; }

        public int DefenderCountryId { get; set; }
        public Country DefenderCountry { get; set; }

        public ICollection<AttackUnit> AttackUnits { get; set; }
    }
}
