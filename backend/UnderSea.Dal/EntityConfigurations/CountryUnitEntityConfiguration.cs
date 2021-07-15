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
    public class CountryUnitEntityConfiguration : IEntityTypeConfiguration<CountryUnit>
    {
        public void Configure(EntityTypeBuilder<CountryUnit> builder)
        {
            builder.HasData(
                new CountryUnit()
                {
                    UnitId = 1,
                    CountryId = 1,
                    Count = 10,
                    BattlesPlayed = 0
                },
                 new CountryUnit()
                 {
                     UnitId = 1,
                     CountryId = 1,
                     Count = 6,
                     BattlesPlayed = 3
                 },
                  new CountryUnit()
                  {
                      UnitId = 1,
                      CountryId = 1,
                      Count = 17,
                      BattlesPlayed = 5
                  },
                   new CountryUnit()
                   {
                       UnitId = 2,
                       CountryId = 1,
                       Count = 4,
                       BattlesPlayed = 0
                   },
                    new CountryUnit()
                    {
                        UnitId = 2,
                        CountryId = 1,
                        Count = 10,
                        BattlesPlayed = 5
                    },
                     new CountryUnit()
                     {
                         UnitId = 3,
                         CountryId = 1,
                         Count = 10,
                         BattlesPlayed = 4
                     },
                     new CountryUnit()
                     {
                         UnitId = 4,
                         CountryId = 1,
                         Count = 10,
                         BattlesPlayed = 0
                     },
                     new CountryUnit()
                     {
                         UnitId = 5,
                         CountryId = 1,
                         Count = 10,
                         BattlesPlayed = 0
                     }
                );
        }
    }
}
