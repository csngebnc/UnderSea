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
    public class EffectEntityConfiguration : IEntityTypeConfiguration<Effect>
    {
        public void Configure(EntityTypeBuilder<Effect> builder)
        {
            builder.HasData(
                new PopulationEffect()
                {
                    Id = 1,
                    Name = "50 lakost ad a népességhez",
                    EffectType = "effect_population"
                },
                new CoralEffect()
                {
                    Id = 2,
                    Name = "200 korallt termel körönként",
                    EffectType = "effect_coral"
                },
                new MilitaryEffect()
                {
                    Id = 3,
                    Name = "200 egység katonának nyújt szállást",
                    EffectType = "effect_military"
                },
                new MudTractor()
                {
                    Id = 4,
                    Name = "Növeli a korall termesztést 10%-kal",
                    EffectType = "upgrade_effect_mudtractor"
                },
                new MudCombine()
                {
                    Id = 5,
                    Name = "Növeli a korall termesztést 15%-kal",
                    EffectType = "upgrade_effect_mudcombine"
                },
                new CoralWall()
                {
                    Id = 6,
                    Name = "Növeli a védelmi pontokat 20%-kal",
                    EffectType = "upgrade_effect_coralwall"
                },
                new SonarCanon()
                {
                    Id = 7,
                    Name = "Növeli a támadó pontokat 20%-kal",
                    EffectType = "upgrade_effect_sonarcannon"
                },
                new UnderwaterMartialArt()
                {
                    Id = 8,
                    Name = "Növeli a védelmi és támadóerőt pontokat 10%-kal",
                    EffectType = "upgrade_effect_martialart"
                },
                new Alchemy()
                {
                    Id = 9,
                    Name = "Növeli a beszedett adót 30%-kal",
                    EffectType = "upgrade_effect_alchemy"
                }
            );
        }
    }
}
