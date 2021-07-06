using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Models;

namespace UnderSea.Dal.EntityConfigurations
{
    public class BuildingEffectEntityConfiguration : IEntityTypeConfiguration<BuildingEffect>
    {
        public void Configure(EntityTypeBuilder<BuildingEffect> builder)
        {
            builder.HasData(
                 new BuildingEffect()
                 {
                     BuildingId = 1,
                     EffectId = 1
                 },
                 new BuildingEffect()
                 {
                     BuildingId = 1,
                     EffectId = 2
                 },
                 new BuildingEffect()
                 {
                     BuildingId = 2,
                     EffectId = 3
                 },
                 new BuildingEffect()
                 {
                     BuildingId = 3,
                     EffectId = 10
                 }
            );
        }
    }
}
