using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Models;
using UnderSea.Model.Models.Joins;

namespace UnderSea.Dal.EntityConfigurations
{
    public class UnitMaterialEntityConfiguration : IEntityTypeConfiguration<UnitMaterial>
    {
        public void Configure(EntityTypeBuilder<UnitMaterial> builder)
        {
            builder.HasData(
                new UnitMaterial()
                {
                    UnitId = 1,
                    MaterialId = 1,
                    Amount = 50
                },
                new UnitMaterial()
                {
                    UnitId = 2,
                    MaterialId = 1,
                    Amount = 50
                },
                new UnitMaterial()
                {
                    UnitId = 3,
                    MaterialId = 1,
                    Amount = 100
                },
                new UnitMaterial()
                {
                    UnitId = 4,
                    MaterialId = 1,
                    Amount = 50
                }
                );
        }
    }
}
