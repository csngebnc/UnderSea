using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public abstract class Effect
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "A hatás nevét kötelező megadni!")]
        [StringLength(100, ErrorMessage = "A hatás neve maximum 100 karakter hosszú lehet!")]
        public string Name { get; set; }

        public ICollection<BuildingEffect> BuildingEffects { get; set; }
        public ICollection<UpgradeEffect> UpgradeEffects { get; set; }

        public abstract void ApplyEffect(Country country);
        public abstract void RemoveEffect(Country country);

    }
}
