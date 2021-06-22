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


    }
}
