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

            modelBuilder.Entity<PopulationEffect>().HasData(new PopulationEffect { Id = 1, Name = "50 lakost ad a népességhez" });
            modelBuilder.Entity<CoralEffect>().HasData(new CoralEffect { Id = 2, Name = "200 korallt termel körönként" });
            modelBuilder.Entity<MilitaryEffect>().HasData(new MilitaryEffect { Id = 3, Name = "200 egység katonának nyújt szállást" });
            modelBuilder.Entity<MudTractor>().HasData(new MudTractor { Id = 4, Name = "Növeli a korall termesztést 10%-kal" });
            modelBuilder.Entity<MudCombine>().HasData(new MudCombine { Id = 5, Name = "Növeli a korall termesztést 15%-kal" });
            modelBuilder.Entity<CoralWall>().HasData(new CoralWall { Id = 6, Name = "Növeli a védelmi pontokat 20%-kal" });
            modelBuilder.Entity<SonarCanon>().HasData(new SonarCanon { Id = 7, Name = "Növeli a támadó pontokat 20%-kal" });
            modelBuilder.Entity<UnderwaterMartialArt>().HasData(new UnderwaterMartialArt { Id = 8, Name = "Növeli a védelmi és támadóerőt pontokat 10%-kal" });
            modelBuilder.Entity<Alchemy>().HasData(new Alchemy { Id = 9, Name = "Növeli a beszedett adót 30%-kal" });

            modelBuilder.ApplyConfiguration(new WorldEntityConfiguration());
            modelBuilder.ApplyConfiguration(new UserEntityConfiguration());
            modelBuilder.ApplyConfiguration(new CountryEntityConfiguration());
            modelBuilder.ApplyConfiguration(new BuildingEntityConfiguration());
            modelBuilder.ApplyConfiguration(new UnitEntityConfiguration());
            //modelBuilder.ApplyConfiguration(new EffectEntityConfiguration());
            modelBuilder.ApplyConfiguration(new UpgradeEntityConfiguration());
            modelBuilder.ApplyConfiguration(new BuildingEffectEntityConfiguration());
            modelBuilder.ApplyConfiguration(new UpgradeEffectEntityConfiguration());
        }


    }
}
