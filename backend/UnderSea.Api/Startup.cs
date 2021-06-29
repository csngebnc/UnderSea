using Hangfire;
using Hangfire.Common;
using Hangfire.SqlServer;
using IdentityServer4;
using IdentityServer4.AccessTokenValidation;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using NSwag;
using NSwag.Generation.Processors.Security;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Mapper;
using UnderSea.Bll.Services;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Bll.SignalR;
using UnderSea.Dal.Data;
using UnderSea.Model.Models;

namespace UnderSea.Api
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddCors(options =>
            {
                options.AddPolicy("CorsPolicy", builder => builder
                .WithOrigins(new string[] { "http://localhost:4200", "https://localhost:4200" })
                .AllowAnyMethod()
                .AllowAnyHeader()
                .AllowCredentials());
            });

            // Add Hangfire services.
            services.AddHangfire(configuration =>
            {
                configuration
                            .SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
                            .UseSimpleAssemblyNameTypeSerializer()
                            .UseRecommendedSerializerSettings()
                            .UseSqlServerStorage(Configuration.GetConnectionString("AzureHangfireDbConnection"), new SqlServerStorageOptions
                            {
                                CommandBatchMaxTimeout = TimeSpan.FromMinutes(5),
                                SlidingInvisibilityTimeout = TimeSpan.FromMinutes(5),
                                QueuePollInterval = TimeSpan.Zero,
                                UseRecommendedIsolationLevel = true,
                                DisableGlobalLocks = true
                            });
            });

            // Add the processing server as IHostedService
            services.AddHangfireServer();

            

            services.AddDbContext<UnderSeaDbContext>(options =>
                options.UseSqlServer(
                    //Configuration.GetConnectionString("DefaultConnection")));
                    Configuration.GetConnectionString("AzureSqlDbConnection")));

            services.AddSwaggerDocument();

            services.AddDatabaseDeveloperPageExceptionFilter();

            services.AddDefaultIdentity<User>(options => options.SignIn.RequireConfirmedAccount = false)
                .AddDefaultTokenProviders()
                .AddEntityFrameworkStores<UnderSeaDbContext>();

            services.AddAutoMapper(typeof(AutoMapperProfiles));

            services.AddHttpContextAccessor();
            services.AddScoped<IIdentityService, IdentityService>();

            services.AddTransient<IUserService, UserService>();
            services.AddTransient<IUpgradeService, UpgradeService>();
            services.AddTransient<IBattleService, BattleService>();
            services.AddTransient<IBuildingService, BuildingService>();
            services.AddTransient<IRoundService, RoundService>();

            services.AddIdentityServer()
                .AddDeveloperSigningCredential()
                .AddInMemoryPersistedGrants()
                .AddInMemoryIdentityResources(Configuration.GetSection("IdentityServer:IdentityResources"))
                .AddInMemoryApiResources(Configuration.GetSection("IdentityServer:ApiResources"))
                .AddInMemoryApiScopes(Configuration.GetSection("IdentityServer:ApiScopes"))
                .AddInMemoryClients(Configuration.GetSection("IdentityServer:Clients"))
                .AddAspNetIdentity<User>();

            JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();
            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            })
                .AddJwtBearer(options =>
                {
                    options.Authority = "https://localhost:5001";
                    options.Audience = "undersea-api";
                    options.RequireHttpsMetadata = false;
                }
                );

            services.AddControllersWithViews();
            services.AddRazorPages(); 
            services.AddSignalR();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(UnderSeaDbContext context,IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseMigrationsEndPoint();
            }
            else
            {
                app.UseExceptionHandler("/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseCors("CorsPolicy");

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseHangfireDashboard("/hangfire");

            var manager = new RecurringJobManager();
            //manager.AddOrUpdate("Next round", Job.FromExpression(() => new RoundService(context).NextRound()), Cron.Minutely());

            app.UseOpenApi();
            app.UseSwaggerUi3();

            app.UseRouting();

            app.UseAuthentication();
            app.UseIdentityServer();
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                       name: "default",
                       pattern: "{controller}/{action=Index}/{id?}");
                endpoints.MapRazorPages();
                endpoints.MapHub<RoundHub>("/roundHub");
            });
        }
    }
}
