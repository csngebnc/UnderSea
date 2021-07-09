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
        public int Count { get; set; }

        public int AttackId { get; set; }
        public Attack Attack { get; set; }

        public int UnitId { get; set; }
        public Unit Unit { get; set; }
        public int BattlesPlayed { get; set; }
        public int GetLevel()
            => BattlesPlayed >= 5 ? 3 : BattlesPlayed >= 3 ? 2 : 1;
    }
}
