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
    public class EventEntityConfiguration : IEntityTypeConfiguration<Event>
    {
        public void Configure(EntityTypeBuilder<Event> builder)
        {
            builder.HasData(
                new Event
                {
                    Id = 1,
                    Name = "Pestis"
                },
                new Event
                {
                    Id = 2,
                    Name = "Víz alatti tűz"
                },
                new Event
                {
                    Id = 3,
                    Name = "Aranybánya"
                },
                new Event
                {
                    Id = 4,
                    Name = "Jó termés"
                },
                new Event
                {
                    Id = 5,
                    Name = "Rossz termés"
                },
                new Event
                {
                    Id = 6,
                    Name = "Elégedett katonák"
                },
                new Event
                {
                    Id = 7,
                    Name = "Elégedetlen katonák"
                },
                new Event
                {
                    Id = 8,
                    Name = "Elégedett emberek"
                },
                new Event
                {
                    Id = 9,
                    Name = "Elégedetlen emberek"
                }
            );
        }
    }
}
