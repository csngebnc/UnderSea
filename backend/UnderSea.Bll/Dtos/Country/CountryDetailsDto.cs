using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos.Material;

namespace UnderSea.Bll.Dtos
{
    public class CountryDetailsDto
    {
        public int MaxUnitCount { get; set; }
        public int Coral { get; set; }
        public int Pearl { get; set; }
        public ICollection<MaterialDto> Materials { get; set; }
        public int Population { get; set; }
        public bool HasSonarCanon { get; set; }

        public IEnumerable<BuildingInfoDto> Buildings { get; set; }
        public ICollection<BattleUnitDto> Units { get; set; }
    }
}
