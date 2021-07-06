using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;
using UnderSea.Model.Models.Materials;

namespace UnderSea.Dal.EntityConfigurations
{
    public class MaterialEntityConfiguration : IEntityTypeConfiguration<Material>
    {
        public void Configure(EntityTypeBuilder<Material> builder)
        {
            builder.HasData(
                new Material()
                {
                    Id = 1,
                    Name = "gyöngy",
                    MaterialType = MaterialTypeConstants.Pearl,
                    ImageUrl = "https://underseastorage.blob.core.windows.net/currency/shell.svg"
                },
                new Material()
                {
                    Id = 2,
                    Name = "korall",
                    MaterialType = MaterialTypeConstants.Coral,
                    ImageUrl = "https://underseastorage.blob.core.windows.net/currency/coral.svg"
                },
                new Material()
                {
                    Id = 3,
                    Name = "kő",
                    MaterialType = MaterialTypeConstants.Stone,
                    ImageUrl = "https://underseastorage.blob.core.windows.net/currency/stone.png"
                }
            );
        }
    }
}
