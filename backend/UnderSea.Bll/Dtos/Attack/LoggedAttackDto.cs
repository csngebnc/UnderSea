using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Enums;

namespace UnderSea.Bll.Dtos
{
    public class LoggedAttackDto
    {
        public string AttackedCountryName { get; set; }
        public ICollection<BattleUnitDto> Units { get; set; }
        public FightOutcome Outcome { get; set; }
    }
}
