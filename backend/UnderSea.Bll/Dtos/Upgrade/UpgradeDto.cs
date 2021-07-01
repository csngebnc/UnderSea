using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class UpgradeDto
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "A fejlesztés nevét kötelező megadni!")]
        [StringLength(100, ErrorMessage = "A fejlesztés neve maximum 100 karakter hosszú lehet!")]
        public string Name { get; set; }
        public bool DoesExist { get; set; }
        public bool IsUnderConstruction { get; set; }
        public int RemainingTime { get; set; }
        public ICollection<EffectDto> Effects { get; set; }
    }
}
