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
    public class BuildingMaterialEntityConfiguration : IEntityTypeConfiguration<BuildingMaterial>
    {
        public void Configure(EntityTypeBuilder<BuildingMaterial> builder)
        {
            builder.HasData(
                new BuildingMaterial()
                {
                    BuildingId = 1,
                    MaterialId = 1,
                    Amount = 1000
                },
                new BuildingMaterial()
                {
                    BuildingId = 1,
                    MaterialId = 3,
                    Amount = 50
                },
                 new BuildingMaterial()
                 {
                     BuildingId = 2,
                     MaterialId = 1,
                     Amount = 1000
                 },
                new BuildingMaterial()
                {
                    BuildingId = 2,
                    MaterialId = 3,
                    Amount = 50
                },
                 new BuildingMaterial()
                 {
                     BuildingId = 3,
                     MaterialId = 1,
                     Amount = 1000
                 }
                );
        }
    }
}
