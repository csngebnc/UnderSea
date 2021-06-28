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
    public class WorldEntityConfiguration : IEntityTypeConfiguration<World>
    {
        public void Configure(EntityTypeBuilder<World> builder)
        {
            builder.HasData( new World() { Id = 1, Round = 1 });
        }
    }
}
