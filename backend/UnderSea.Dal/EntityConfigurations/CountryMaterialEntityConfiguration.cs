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
    public class CountryMaterialEntityConfiguration : IEntityTypeConfiguration<CountryMaterial>
    {
        public void Configure(EntityTypeBuilder<CountryMaterial> builder)
        {
            builder.HasData(
                new CountryMaterial()
                {
                    MaterialId = 1,
                    Amount = 5000,
                    BaseProduction = 200,
                    CountryId = 1,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 2,
                    Amount = 1000,
                    BaseProduction = 200,
                    CountryId = 1,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 3,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 1,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 1,
                    Amount = 5000,
                    BaseProduction = 200,
                    CountryId = 2,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 2,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 2,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 3,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 2,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 1,
                    Amount = 5000,
                    BaseProduction = 200,
                    CountryId = 3,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 2,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 3,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 3,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 3,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 1,
                    Amount = 5000,
                    BaseProduction = 200,
                    CountryId = 4,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 2,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 4,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 3,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 4,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 1,
                    Amount = 5000,
                    BaseProduction = 200,
                    CountryId = 5,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 2,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 5,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 3,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 5,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 1,
                    Amount = 5000,
                    BaseProduction = 200,
                    CountryId = 6,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 2,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 6,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 3,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 6,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 1,
                    Amount = 5000,
                    BaseProduction = 200,
                    CountryId = 7,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 2,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 7,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 3,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 7,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 1,
                    Amount = 5000,
                    BaseProduction = 200,
                    CountryId = 8,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 2,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 8,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 3,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 8,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 1,
                    Amount = 5000,
                    BaseProduction = 200,
                    CountryId = 9,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 2,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 9,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 3,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 9,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 1,
                    Amount = 5000,
                    BaseProduction = 200,
                    CountryId = 10,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 2,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 10,
                    Multiplier = 1
                },
                new CountryMaterial()
                {
                    MaterialId = 3,
                    Amount = 0,
                    BaseProduction = 0,
                    CountryId = 10,
                    Multiplier = 1
                }
                );
        }
    }
}
