using IdentityServer4.EntityFramework.Options;
using Microsoft.AspNetCore.ApiAuthorization.IdentityServer;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Dal.Data.Seed;
using UnderSea.Dal.EntityConfigurations;
using UnderSea.Model.Models;

namespace UnderSea.Dal.Data
{
    public class UnderSeaDbContext : IdentityDbContext<User>
    {
        public DbSet<ActiveConstruction> ActiveConstructions { get; set; }
        public DbSet<Attack> Attacks { get; set; }
        public DbSet<AttackUnit> AttackUnits { get; set; }
        public DbSet<Building> Buildings { get; set; }
        public DbSet<BuildingEffect> BuildingEffects { get; set; }
        public DbSet<Country> Countries { get; set; }
        public DbSet<CountryBuilding> CountryBuildings { get; set; }
        public DbSet<CountryUnit> CountryUnits { get; set; }
        public DbSet<CountryUpgrade> CountryUpgrades { get; set; }
        public DbSet<Effect> Effects { get; set; }
        public DbSet<Unit> Units { get; set; }
        public DbSet<Upgrade> Upgrades { get; set; }
        public DbSet<UpgradeEffect> UpgradeEffects { get; set; }
        public DbSet<ActiveUpgrading> ActiveUpgradings { get; set; }
        public DbSet<World> Worlds { get; set; }

        public UnderSeaDbContext(DbContextOptions options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Country>()
                .HasOne(c => c.Owner)
                .WithOne(u => u.Country);


            modelBuilder.Entity<Attack>()
                .HasOne(a => a.AttackerCountry)
                .WithMany(c => c.Attacks)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Attack>()
                .HasOne(a => a.DefenderCountry)
                .WithMany(c => c.Defenses)
                .OnDelete(DeleteBehavior.NoAction);


            modelBuilder.Entity<BuildingEffect>().HasKey(be => new { be.BuildingId, be.EffectId });
            modelBuilder.Entity<CountryUnit>().HasKey(cu => new { cu.CountryId, cu.UnitId });
            modelBuilder.Entity<CountryUpgrade>().HasKey(cu => new { cu.CountryId, cu.UpgradeId });
            modelBuilder.Entity<UpgradeEffect>().HasKey(ue => new { ue.EffectId, ue.UpgradeId });

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

            modelBuilder.Entity<Country>().OwnsOne(p => p.Production);//.HasData(productions);
            modelBuilder.Entity<Country>().OwnsOne(p => p.FightPoint);//.HasData(fightpoints);

            modelBuilder.Entity<Effect>()
                .HasDiscriminator(e => e.EffectType)
                .HasValue<Effect>("effect_base")
                .HasValue<CoralEffect>("effect_coral")
                .HasValue<MilitaryEffect>("effect_military")
                .HasValue<PopulationEffect>("effect_population")
                .HasValue<Alchemy>("upgrade_effect_alchemy")
                .HasValue<CoralWall>("upgrade_effect_coralwall")
                .HasValue<MudCombine>("upgrade_effect_mudcombine")
                .HasValue<MudTractor>("upgrade_effect_mudtractor")
                .HasValue<SonarCanon>("upgrade_effect_sonarcannon")
                .HasValue<UnderwaterMartialArt>("upgrade_effect_martialart");

            modelBuilder.Entity<Effect>()
                .Property(e => e.EffectType)
                .HasMaxLength(200)
                .HasColumnName("effect_type");
            /*
            List<Effect> effects = new List<Effect>();
            effects.Add(new PopulationEffect { Id = 1, Name = "50 lakost ad a népességhez" });
            effects.Add(new CoralEffect { Id = 2, Name = "200 korallt termel körönként" });
            effects.Add(new MilitaryEffect { Id = 3, Name = "200 egység katonának nyújt szállást" });
            effects.Add(new MudTractor { Id = 4, Name = "Növeli a korall termesztést 10%-kal" });
            effects.Add(new MudCombine { Id = 5, Name = "Növeli a korall termesztést 15%-kal" });
            effects.Add(new CoralWall { Id = 6, Name = "Növeli a védelmi pontokat 20%-kal" });
            effects.Add(new SonarCanon { Id = 7, Name = "Növeli a támadó pontokat 20%-kal" });
            effects.Add(new UnderwaterMartialArt { Id = 8, Name = "Növeli a védelmi és támadóerőt pontokat 10%-kal" });
            effects.Add(new Alchemy { Id = 9, Name = "Növeli a beszedett adót 30%-kal" });



            modelBuilder.Entity<User>().HasData(JsonDataLoader.LoadJson<User>("../UnderSea.Dal/Data/Seed/Users"));
            modelBuilder.Entity<World>().HasData(JsonDataLoader.LoadJson<World>("../UnderSea.Dal/Data/Seed/World"));
            modelBuilder.Entity<PopulationEffect>().HasData(effects[0]);
            modelBuilder.Entity<CoralEffect>().HasData(effects[1]);
            modelBuilder.Entity<MilitaryEffect>().HasData(effects[2]);
            modelBuilder.Entity<MudTractor>().HasData(effects[3]);
            modelBuilder.Entity<MudCombine>().HasData(effects[4]);
            modelBuilder.Entity<CoralWall>().HasData(effects[5]);
            modelBuilder.Entity<SonarCanon>().HasData(effects[6]);
            modelBuilder.Entity<UnderwaterMartialArt>().HasData(effects[7]);
            modelBuilder.Entity<Alchemy>().HasData(effects[8]);
            modelBuilder.Entity<Country>().HasData(JsonDataLoader.LoadJson<Country>("../UnderSea.Dal/Data/Seed/Country"));
            modelBuilder.Entity<Building>().HasData(JsonDataLoader.LoadJson<Building>("../UnderSea.Dal/Data/Seed/Building"));
            modelBuilder.Entity<Unit>().HasData(JsonDataLoader.LoadJson<Unit>("../UnderSea.Dal/Data/Seed/Unit"));
            modelBuilder.Entity<Upgrade>().HasData(JsonDataLoader.LoadJson<Upgrade>("../UnderSea.Dal/Data/Seed/Upgrade"));
            modelBuilder.Entity<BuildingEffect>().HasData(JsonDataLoader.LoadJson<BuildingEffect>("../UnderSea.Dal/Data/Seed/BuildingEffect"));
            modelBuilder.Entity<UpgradeEffect>().HasData(JsonDataLoader.LoadJson<UpgradeEffect>("../UnderSea.Dal/Data/Seed/UpgradeEffect"));
            */
        }


    }
}
