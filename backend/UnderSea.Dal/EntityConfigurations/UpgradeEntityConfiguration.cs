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
    public class UpgradeEntityConfiguration : IEntityTypeConfiguration<Upgrade>
    {
        public void Configure(EntityTypeBuilder<Upgrade> builder)
        {
            builder.HasData(
                new Upgrade()
                {
                    Id = 1,
                    Name = "Iszaptraktor",
                    UpgradeTime = 15,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/upgrades/tractor.png"
                },
                new Upgrade()
                {
                    Id = 2,
                    Name = "Iszapkombájn",
                    UpgradeTime = 15,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/upgrades/submarine.png"
                },
                new Upgrade()
                {
                    Id = 3,
                    Name = "Korallfal",
                    UpgradeTime = 15,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/upgrades/coral_wall.png"
                },
                new Upgrade()
                {
                    Id = 4,
                    Name = "Szonárágyú",
                    UpgradeTime = 15,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/upgrades/sonar.png"
                },
                new Upgrade()
                {
                    Id = 5,
                    Name = "Vízalatti harcművészetek",
                    UpgradeTime = 15,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/upgrades/seastar.png"
                },
                new Upgrade()
                {
                    Id = 6,
                    Name = "Alkímia",
                    UpgradeTime = 15,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/upgrades/potion.png"
                }
            );
        }
    }
}
