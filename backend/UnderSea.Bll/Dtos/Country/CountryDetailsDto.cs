using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class CountryDetailsDto
    {
        public int MaxUnitCount { get; set; }
        public int Coral { get; set; }
        public int Pearl { get; set; }
        public int CurrentCoralProduction { get; set; }
        public int CurrentPearlProduction { get; set; }
        public int Population { get; set; }
        public bool HasSonarCanon { get; set; }

        public IEnumerable<BuildingInfoDto> Buildings { get; set; }
        public ICollection<BattleUnitDto> Units { get; set; }
    }
}
