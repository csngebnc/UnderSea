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
    public class UpgradeEffectEntityConfiguration : IEntityTypeConfiguration<UpgradeEffect>
    {
        public void Configure(EntityTypeBuilder<UpgradeEffect> builder)
        {
            builder.HasData(
                new UpgradeEffect()
                {
                    UpgradeId = 1,
                    EffectId = 4
                },
                new UpgradeEffect()
                {
                    UpgradeId = 2,
                    EffectId = 5
                },
                new UpgradeEffect()
                {
                    UpgradeId = 3,
                    EffectId = 6
                },
                new UpgradeEffect()
                {
                    UpgradeId = 4,
                    EffectId = 7
                },
                new UpgradeEffect()
                {
                    UpgradeId = 5,
                    EffectId = 8
                },
                new UpgradeEffect()
                {
                    UpgradeId = 6,
                    EffectId = 9
                }
            );
        }
    }
}
