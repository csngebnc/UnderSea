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
    public class UnitLevelEntityConfiguration : IEntityTypeConfiguration<UnitLevel>
    {
        public void Configure(EntityTypeBuilder<UnitLevel> builder)
        {
            builder.HasData(
                new UnitLevel
                {
                    UnitId = 1,
                    AttackPoint = 6,
                    DefensePoint = 2,
                    MinimumBattles = 0,
                    Level = 1
                },
                new UnitLevel
                {
                    UnitId = 1,
                    AttackPoint = 8,
                    DefensePoint = 3,
                    MinimumBattles = 3,
                    Level = 2
                },
                new UnitLevel
                {
                    UnitId = 1,
                    AttackPoint = 10,
                    DefensePoint = 5,
                    MinimumBattles = 5,
                    Level = 3
                },
                new UnitLevel
                {
                    UnitId = 2,
                    AttackPoint = 2,
                    DefensePoint = 6,
                    MinimumBattles = 0,
                    Level = 1
                },
                new UnitLevel
                {
                    UnitId = 2,
                    AttackPoint = 3,
                    DefensePoint = 8,
                    MinimumBattles = 3,
                    Level = 2
                },
                new UnitLevel
                {
                    UnitId = 2,
                    AttackPoint = 5,
                    DefensePoint = 10,
                    MinimumBattles = 5,
                    Level = 3
                },
                new UnitLevel
                {
                    UnitId = 3,
                    AttackPoint = 5,
                    DefensePoint = 5,
                    MinimumBattles = 0,
                    Level = 1
                },
                new UnitLevel
                {
                    UnitId = 3,
                    AttackPoint = 7,
                    DefensePoint = 7,
                    MinimumBattles = 3,
                    Level = 2
                },
                new UnitLevel
                {
                    UnitId = 3,
                    AttackPoint = 10,
                    DefensePoint = 10,
                    MinimumBattles = 5,
                    Level = 3
                },
                new UnitLevel
                {
                    UnitId = 4,
                    AttackPoint = 0,
                    DefensePoint = 0,
                    MinimumBattles = 0,
                    Level = 1
                },
                new UnitLevel
                {
                    UnitId = 5,
                    AttackPoint = 0,
                    DefensePoint = 0,
                    MinimumBattles = 0,
                    Level = 1
                }
            );
        }
    }
}
