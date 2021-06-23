using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class UserDetailsDto
    {
        public int MaxUnitCount { get; set; }

        public ICollection<BattleUnitDto> Units { get; set; }

        public int CurrentCoral { get; set; }
        public int CurrentPearl { get; set; }

        public int CurrentCoralProduction { get; set; }
        public int CurrentPearlProduction { get; set; }

        public ICollection<BuildingInfoDto> Buildings { get; set; }
    }
}
