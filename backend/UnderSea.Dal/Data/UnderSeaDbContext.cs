using IdentityServer4.EntityFramework.Options;
using Microsoft.AspNetCore.ApiAuthorization.IdentityServer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Models;

namespace UnderSea.Dal.Data
{
    public class UnderSeaDbContext : ApiAuthorizationDbContext<User>
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

        public UnderSeaDbContext(DbContextOptions options, IOptions<OperationalStoreOptions> operationalStoreOptions) : base(options, operationalStoreOptions)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<BuildingEffect>().HasKey(be => new { be.BuildingId, be.EffectId });
            modelBuilder.Entity<CountryUnit>().HasKey(cu => new { cu.CountryId, cu.UnitId });
            modelBuilder.Entity<CountryUpgrade>().HasKey(cu => new { cu.CountryId, cu.UpgradeId });
            modelBuilder.Entity<UpgradeEffect>().HasKey(ue => new { ue.EffectId, ue.UpgradeId });

            modelBuilder.Entity<Country>().OwnsOne(p => p.Production);

            modelBuilder.Entity<Effect>()
                .HasDiscriminator<string>("effect_type")
                .HasValue<Effect>("effect_base")
                .HasValue<CoralEffect>("effect_coral")
                .HasValue<MilitaryEffect>("effect_military")
                .HasValue<PopulationEffect>("effect_population");

            modelBuilder.Entity<Upgrade>()
                .HasDiscriminator<string>("upgrade_type")
                .HasValue<Upgrade>("upgrade_base")
                .HasValue<Alchemy>("upgrade_alchemy")
                .HasValue<CoralWall>("upgrade_coralwall")
                .HasValue<MudCombine>("upgrade_mudcombine")
                .HasValue<MudTractor>("upgrade_mudtractor")
                .HasValue<SonarCanon>("upgrade_sonarcannon")
                .HasValue<UnderwaterVehicles>("upgrade_underwater_vehicles");
        }


    }
}
