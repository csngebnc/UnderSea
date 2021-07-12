using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Models.Joins;

namespace UnderSea.Dal.EntityConfigurations
{
    public class EventEffectEntityConfiguration : IEntityTypeConfiguration<EventEffect>
    {
        public void Configure(EntityTypeBuilder<EventEffect> builder)
        {
            builder.HasData(
                new EventEffect()
                {
                    EventId = 1,
                    EffectId = 11
                },
                new EventEffect()
                {
                    EventId = 2,
                    EffectId = 12
                },
                new EventEffect()
                {
                    EventId = 3,
                    EffectId = 13
                },
                new EventEffect()
                {
                    EventId = 4,
                    EffectId = 14
                },
                new EventEffect()
                {
                    EventId = 5,
                    EffectId = 15
                },
                new EventEffect()
                {
                    EventId = 6,
                    EffectId = 16
                },
                new EventEffect()
                {
                    EventId = 7,
                    EffectId = 17
                },
                new EventEffect()
                {
                    EventId = 8,
                    EffectId = 18
                },
                new EventEffect()
                {
                    EventId = 9,
                    EffectId = 19
                }
            );
        }
    }
}
