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
using UnderSea.Model.Constants;
using UnderSea.Model.Models;
using UnderSea.Model.Models.Effects;
using UnderSea.Model.Models.Events;
using UnderSea.Model.Models.Joins;
using UnderSea.Model.Models.Materials;

namespace UnderSea.Dal.Data
{
    public class UnderSeaDbContext : IdentityDbContext<User>
    {
        public DbSet<ActiveConstruction> ActiveConstructions { get; set; }
        public DbSet<Attack> Attacks { get; set; }
        public DbSet<AttackUnit> AttackUnits { get; set; }
        public DbSet<SpyReport> SpyReports { get; set; }
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

        public DbSet<Material> Materials { get; set; }
        public DbSet<BuildingMaterial> BuildingMaterials { get; set; }
        public DbSet<UnitMaterial> UnitMaterials { get; set; }
        public DbSet<CountryMaterial> CountryMaterials { get; set; }
        public DbSet<UnitLevel> UnitLevels { get; set; }

        public DbSet<Event> Events { get; set; }
        public DbSet<EventEffect> EventEffects { get; set; }
        public DbSet<CountryEvent> CountryEvents { get; set; }
        public DbSet<WorldWinner> WorldWinners { get; set; }

        public UnderSeaDbContext(DbContextOptions options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Country>()
                .HasOne(c => c.Owner)
                .WithOne(u => u.Country);

            modelBuilder.Entity<Country>()
                .HasMany(c => c.SentSpies)
                .WithOne(sr => sr.SpySenderCountry)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Attack>()
                .HasOne(a => a.AttackerCountry)
                .WithMany(c => c.Attacks)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Country>()
                .HasMany(c => c.CountryEvents)
                .WithOne(e => e.Country)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Attack>()
                .HasOne(a => a.DefenderCountry)
                .WithMany(c => c.Defenses)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<BuildingMaterial>()
                .HasKey(c => new { c.BuildingId, c.MaterialId });
                                    
            modelBuilder.Entity<UnitMaterial>()
                .HasKey(c => new { c.UnitId, c.MaterialId });

            modelBuilder.Entity<CountryMaterial>()
                .HasKey(c => new { c.CountryId, c.MaterialId });

            modelBuilder.Entity<UnitLevel>()
                .HasKey(ul => new { ul.UnitId, ul.Level });

            modelBuilder.Entity<CountryUnit>().HasKey(cu => new { cu.CountryId, cu.UnitId, cu.BattlesPlayed });
            modelBuilder.Entity<CountryUpgrade>().HasKey(cu => new { cu.CountryId, cu.UpgradeId });
            modelBuilder.Entity<UpgradeEffect>().HasKey(ue => new { ue.EffectId, ue.UpgradeId });
            modelBuilder.Entity<EventEffect>().HasKey(ue => new { ue.EffectId, ue.EventId });
            modelBuilder.Entity<BuildingEffect>().HasKey(be => new { be.BuildingId, be.EffectId });

            modelBuilder.Entity<Country>().OwnsOne(p => p.FightPoint);

            modelBuilder.Entity<Effect>()
                .HasDiscriminator(e => e.EffectType)
                .HasValue<Effect>(EffectTypeConstants.Base)
                .HasValue<StoneEffect>(EffectTypeConstants.StoneEffect)
                .HasValue<CoralEffect>(EffectTypeConstants.CoralEffect)
                .HasValue<MilitaryEffect>(EffectTypeConstants.MilitaryEffect)
                .HasValue<PopulationEffect>(EffectTypeConstants.PopulationEffect)
                .HasValue<Alchemy>(EffectTypeConstants.Alchemy)
                .HasValue<CoralWall>(EffectTypeConstants.CoralWall)
                .HasValue<MudCombine>(EffectTypeConstants.MudCombine)
                .HasValue<MudTractor>(EffectTypeConstants.MudTractor)
                .HasValue<SonarCanon>(EffectTypeConstants.SonarCanon)
                .HasValue<UnderwaterMartialArt>(EffectTypeConstants.UnderwaterMartialArt);

            modelBuilder.Entity<Material>()
                .Property(m => m.MaterialType)
                .HasMaxLength(200)
                .HasColumnName("material_type");

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
            modelBuilder.Entity<StoneEffect>().HasData(new StoneEffect { Id = 10, Name = "25 követ termel körönként" });
            modelBuilder.Entity<PlagueEffect>().HasData(new PlagueEffect { Id = 11, Name = " Az országodban kitört a pestis, elveszítesz 50 embert és egy áramlásirányítót." });
            modelBuilder.Entity<WaterFire>().HasData(new WaterFire { Id = 12, Name = "Az országodban tűz ütött ki és leégett egy zátonyvár." });
            modelBuilder.Entity<Goldmine>().HasData(new Goldmine { Id = 13, Name = "Az embereid felfedeztek egy új aranybányát, kapsz 1000 bónusz gyöngyöt." });
            modelBuilder.Entity<GoodHarvest>().HasData(new GoodHarvest { Id = 14, Name = "Minden áramlásirányító 250 korallt ad ebben a körben." });
            modelBuilder.Entity<BadHarvest>().HasData(new BadHarvest { Id = 15, Name = "Minden áramlásirányító 150 korallt ad ebben a körben." });
            modelBuilder.Entity<SatisfiedUnits>().HasData(new SatisfiedUnits { Id = 16, Name = "Katonáid elégedettek ebben a körben, minden katona támadása nő eggyel." });
            modelBuilder.Entity<UnsatisfiedUnits>().HasData(new UnsatisfiedUnits { Id = 17, Name = "Katonáid elégedetlenek ebben a körben, minden katona támadása csökken eggyel." });
            modelBuilder.Entity<SatisfiedPeople>().HasData(new SatisfiedPeople { Id = 18, Name = "Az országodban elégedettek az emberek, ezért extra 50 ember költözött be és építettek maguknak egy áramlásirányítót" });
            modelBuilder.Entity<UnsatisfiedPeople>().HasData(new UnsatisfiedPeople { Id = 19, Name = "Az országodban elégedetlenek az emberek, ezért 50 ember elköltözött és az áramlásirányítójuk lerombolták" });

            modelBuilder.ApplyConfiguration(new WorldEntityConfiguration());
            modelBuilder.ApplyConfiguration(new UserEntityConfiguration());
            modelBuilder.ApplyConfiguration(new MaterialEntityConfiguration());
            modelBuilder.ApplyConfiguration(new CountryEntityConfiguration());
            modelBuilder.ApplyConfiguration(new CountryMaterialEntityConfiguration());
            modelBuilder.ApplyConfiguration(new BuildingEntityConfiguration());
            modelBuilder.ApplyConfiguration(new EventEntityConfiguration());
            modelBuilder.ApplyConfiguration(new BuildingMaterialEntityConfiguration());
            modelBuilder.ApplyConfiguration(new UnitEntityConfiguration());
            modelBuilder.ApplyConfiguration(new UnitMaterialEntityConfiguration());
            modelBuilder.ApplyConfiguration(new UnitLevelEntityConfiguration());
            //modelBuilder.ApplyConfiguration(new EffectEntityConfiguration());
            modelBuilder.ApplyConfiguration(new UpgradeEntityConfiguration());
            modelBuilder.ApplyConfiguration(new BuildingEffectEntityConfiguration());
            modelBuilder.ApplyConfiguration(new UpgradeEffectEntityConfiguration());
            modelBuilder.ApplyConfiguration(new EventEffectEntityConfiguration());
        }


    }
}
