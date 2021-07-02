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
    public class CountryEntityConfiguration : IEntityTypeConfiguration<Country>
    {
        public void Configure(EntityTypeBuilder<Country> builder)
        {
            builder.HasData(
                 new Country()
                 {
                     Id = 1,
                     Name = "Center",
                     OwnerId = "af378505-14cb-4f49-bb01-ba2c8fdef77d",
                     Population = 100,
                     Coral = 10000,
                     Pearl = 10000,
                     MaxUnitCount = 100,
                     WorldId = 1
                 }
                );

            builder.HasData(
                 new Country()
                 {
                     Id = 2,
                     Name = "Melrose",
                     OwnerId = "72ff37e8-5888-47c6-9ad7-15844a6449b1",
                     Population = 100,
                     Coral = 10000,
                     Pearl = 10000,
                     MaxUnitCount = 100,
                     WorldId = 1
                 }
                );


            builder.HasData(
                  new Country()
                  {
                      Id = 3,
                      Name = "Gale",
                      OwnerId = "a63a97aa-4ae8-4185-8621-be02286b1542",
                      Population = 100,
                      Coral = 10000,
                      Pearl = 10000,
                      MaxUnitCount = 100,
                      WorldId = 1
                  }
                );

            builder.HasData(
                 new Country()
                 {
                     Id = 4,
                     Name = "Algoma",
                     OwnerId = "c4393fff-8d3a-4508-9245-794916e9e997",
                     Population = 100,
                     Coral = 10000,
                     Pearl = 10000,
                     MaxUnitCount = 100,
                     WorldId = 1
                 }
               );


            builder.HasData(
                  new Country()
                  {
                      Id = 5,
                      Name = "Carioca",
                      OwnerId = "cbbd70fb-06cd-4368-af10-93c237980d8c",
                      Population = 100,
                      Coral = 10000,
                      Pearl = 10000,
                      MaxUnitCount = 100,
                      WorldId = 1
                  }
               );


            builder.HasData(
                  new Country()
                  {
                      Id = 6,
                      Name = "Norway Maple",
                      OwnerId = "392a9574-11a7-4f01-add1-4980933cc7a6",
                      Population = 100,
                      Coral = 10000,
                      Pearl = 10000,
                      MaxUnitCount = 100,
                      WorldId = 1
                  }
               );

            builder.HasData(
                  new Country()
                  {
                      Id = 7,
                      Name = "Melody",
                      OwnerId = "bf37d8cc-0744-4054-9fe1-603e6829799a",
                      Population = 100,
                      Coral = 10000,
                      Pearl = 10000,
                      MaxUnitCount = 100,
                      WorldId = 1
                  }
               );


            builder.HasData(
                  new Country()
                  {
                      Id = 8,
                      Name = "Kipling",
                      OwnerId = "488d40fe-e2c5-41e3-b2d9-dea16b7c2897",
                      Population = 100,
                      Coral = 10000,
                      Pearl = 10000,
                      MaxUnitCount = 100,
                      WorldId = 1
                  }
               );



            builder.HasData(
                   new Country()
                   {
                       Id = 9,
                       Name = "Londonderry",
                       OwnerId = "0b62f843-4357-423b-83d0-a2506ac91d5c",
                       Population = 100,
                       Coral = 10000,
                       Pearl = 10000,
                       MaxUnitCount = 100,
                       WorldId = 1
                   }
               );


            builder.HasData(
                   new Country()
                   {
                       Id = 10,
                       Name = "Arkansas",
                       OwnerId = "c0b59d8d-58cc-4a54-a045-bf2a9341c658",
                       Population = 100,
                       Coral = 10000,
                       Pearl = 10000,
                       MaxUnitCount = 100,
                       WorldId = 1
                   }
               );

            
            List<object> productions = new List<object>();
            List<object> fightpoints = new List<object>();
            for (int i = 1; i <= 10; i++)
            {
                productions.Add(new
                {
                    CountryId = i,
                    BaseCoralProduction = 10,
                    BasePearlProduction = 200,
                    CoralProductionMultiplier = 1.0,
                    PearlProductionMultiplier = 1.0
                });

                fightpoints.Add(new
                {
                    CountryId = i,
                    AttackPointMultiplier = 1.0,
                    DefensePointMultiplier = 1.0
                });
            }
            builder.OwnsOne(e => e.Production).HasData(productions);
            builder.OwnsOne(e => e.FightPoint).HasData(fightpoints);
            
        }
    }
}
