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
    public class UnitEntityConfiguration : IEntityTypeConfiguration<Unit>
    {
        public void Configure(EntityTypeBuilder<Unit> builder)
        {
            builder.HasData(
                new Unit()
                {
                    Id = 1,
                    Name = "Rohamfóka",
                    Price = 50,
                    MercenaryPerRound = 1,
                    SupplyPerRound = 1,
                    AttackPoint = 6,
                    DefensePoint = 2
                },
                new Unit()
                {
                    Id = 2,
                    Name = "Csatacsikó",
                    Price = 50,
                    MercenaryPerRound = 1,
                    SupplyPerRound = 1,
                    AttackPoint = 2,
                    DefensePoint = 6
                },
                new Unit()
                {
                    Id = 3,
                    Name = "Lézercápa",
                    Price = 100,
                    MercenaryPerRound = 3,
                    SupplyPerRound = 2,
                    AttackPoint = 5,
                    DefensePoint = 5
                }
            );
        }
    }
}
