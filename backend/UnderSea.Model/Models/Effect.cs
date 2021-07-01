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
        public string Name { get; set; }

        public string EffectType { get; set; }

        public ICollection<BuildingEffect> BuildingEffects { get; set; }
        public ICollection<UpgradeEffect> UpgradeEffects { get; set; }

        public abstract void ApplyEffect(Country country);
        public abstract void RemoveEffect(Country country);

    }
}
