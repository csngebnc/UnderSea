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
    public class BuildingEntityConfiguration : IEntityTypeConfiguration<Building>
    {
        public void Configure(EntityTypeBuilder<Building> builder)
        {
            builder.HasData(
                new Building()
                {
                    Id = 1,
                    Name = "Áramlásirányító",
                    Price = 1000,
                    ConstructionTime = 5
                },
                new Building()
                {
                    Id = 2,
                    Name = "Zátonyvár",
                    Price = 1000,
                    ConstructionTime = 5
                }
            );
        }
    }
}
