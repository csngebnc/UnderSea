using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;
using UnderSea.Model.Models;

namespace UnderSea.Dal.EntityConfigurations
{
    public class UnitEntityConfiguration : IEntityTypeConfiguration<Unit>
    {
        public void Configure(EntityTypeBuilder<Unit> builder)
        {
            builder.HasData(
                new Unit()
                {
                    Id = 1,
                    Name = UnitNameConstants.RohamFoka,
                    MercenaryPerRound = 1,
                    SupplyPerRound = 1,
                    AttackPoint = 6,
                    DefensePoint = 2,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/units/seal.svg"
                },
                new Unit()
                {
                    Id = 2,
                    Name = UnitNameConstants.Csatacsiko,
                    MercenaryPerRound = 1,
                    SupplyPerRound = 1,
                    AttackPoint = 2,
                    DefensePoint = 6,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/units/seahorse.svg"
                },
                new Unit()
                {
                    Id = 3,
                    Name = UnitNameConstants.Lezercapa,
                    MercenaryPerRound = 3,
                    SupplyPerRound = 2,
                    AttackPoint = 5,
                    DefensePoint = 5,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/units/shark.svg"
                },
                new Unit()
                {
                    Id = 4,
                    Name = UnitNameConstants.Felfedezo,
                    MercenaryPerRound = 1,
                    SupplyPerRound = 1,
                    AttackPoint = 0,
                    DefensePoint = 0,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/units/spy.png"
                },
                new Unit()
                {
                    Id = 5,
                    Name = UnitNameConstants.Hadvezer,
                    MercenaryPerRound = 4,
                    SupplyPerRound = 2,
                    AttackPoint = 0,
                    DefensePoint = 0,
                    ImageUrl = @"https://underseastorage.blob.core.windows.net/units/general.png"
                }
            );
        }
    }
}
