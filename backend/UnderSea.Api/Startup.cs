using Autofac;
using FluentValidation;
using FluentValidation.AspNetCore;
using Hangfire;
using Hangfire.SqlServer;
using Hellang.Middleware.ProblemDetails;
using IdentityServer4.Configuration;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using NSwag;
using NSwag.AspNetCore;
using NSwag.Generation.Processors.Security;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Reflection;
using UnderSea.Api.AuthFilter;
using UnderSea.Api.Services;
using UnderSea.Api.SignalR;
using UnderSea.Bll.Mapper;
using UnderSea.Bll.Services;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Bll.Validation.Exceptions;
using UnderSea.Bll.Validation.ProblemDetails;
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
                options.AddPolicy("CorsPolicy", builder =>
                {
                    builder.WithOrigins(Configuration.GetSection("AllowedOrigins").Get<string[]>())
                           .AllowAnyMethod()
                           .AllowAnyHeader()
                           .AllowCredentials();
                });
            });

            // Add Hangfire services.
            services.AddHangfire(configuration =>
            {
                configuration
                    .SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
                    .UseSimpleAssemblyNameTypeSerializer()
                    .UseRecommendedSerializerSettings()
                    .UseSqlServerStorage(Configuration.GetConnectionString("DefaultHangfireConnection"), new SqlServerStorageOptions
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
                    Configuration.GetConnectionString("DefaultConnection")));

            services.AddDatabaseDeveloperPageExceptionFilter();

            services.AddDefaultIdentity<User>(options => options.SignIn.RequireConfirmedAccount = false)
                .AddDefaultTokenProviders()
                .AddEntityFrameworkStores<UnderSeaDbContext>();

            services.AddAutoMapper(typeof(AutoMapperProfiles));

            services.AddHttpContextAccessor();

            services.AddScoped<IIdentityService, IdentityService>();
            services.AddTransient<IHubService, RoundHubService>();
            services.AddTransient<IRoundService, RoundService>();

            services.AddIdentityServer(options =>
            {
                options.UserInteraction = new UserInteractionOptions()
                {
                    LogoutUrl = "/",
                    LoginUrl = "/",

                    LoginReturnUrlParameter = "returnUrl"
                };
            })
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
                    options.Authority = Configuration.GetValue<string>("Authentication:Authority");
                    options.Audience = Configuration.GetValue<string>("Authentication:Audience");
                    options.RequireHttpsMetadata = false;
                }
                );

            services.AddAuthorization(options =>
            {
                // There is no role based authorization in the app, as all users are in the same role
                // But there is a scope based authorization for the clients.
                // The client app can only execute the request if it has the required scope
                options.AddPolicy("api-openid", policy => policy.RequireAuthenticatedUser()
                    .RequireClaim("scope", "api-openid")
                    .AddAuthenticationSchemes(JwtBearerDefaults.AuthenticationScheme));

                options.DefaultPolicy = options.GetPolicy("api-openid");
            });

            services.AddOpenApiDocument(config =>
            {
                config.Title = "UnderSea API";
                config.Description = "Strategy game api";
                config.DocumentName = "UnderSea";

                config.AddSecurity("OAuth2", new OpenApiSecurityScheme
                {
                    OpenIdConnectUrl =
                        $"{Configuration.GetValue<string>("Authentication:Authority")}/.well-known/openid-configuration",
                    Scheme = "Bearer",
                    Type = OpenApiSecuritySchemeType.OAuth2,
                    Flows = new OpenApiOAuthFlows
                    {
                        AuthorizationCode = new OpenApiOAuthFlow
                        {
                            AuthorizationUrl =
                                $"{Configuration.GetValue<string>("Authentication:Authority")}/connect/authorize",
                            TokenUrl = $"{Configuration.GetValue<string>("Authentication:Authority")}/connect/token",
                            Scopes = new Dictionary<string, string>
                            {
                                { "openid", "OpenId" },
                                { "api-openid", "all" }
                            }
                        }
                    }
                });

                config.OperationProcessors.Add(new AspNetCoreOperationSecurityScopeProcessor("OAuth2"));
            });

            services.AddProblemDetails(ConfigureProblemDetails);

            services.AddControllersWithViews().AddFluentValidation(fv =>
            {
                fv.DisableDataAnnotationsValidation = true;
            });
            services.AddRazorPages();
            services.AddSignalR();
        }

        public void ConfigureContainer(ContainerBuilder builder)
        {
            builder.RegisterAssemblyTypes(Assembly.Load("UnderSea.Bll"))
                .Where(x => x.Name.EndsWith("Service"))
                .AsImplementedInterfaces()
                .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(Assembly.Load("UnderSea.Bll"))
                .Where(x => x.Name.EndsWith("Validator"))
                .AsImplementedInterfaces()
                .InstancePerDependency();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseMigrationsEndPoint();
            }
            else
            {
                app.UseDeveloperExceptionPage();
                //app.UseExceptionHandler("/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseCors("CorsPolicy");

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseHangfireDashboard("/hangfire", new DashboardOptions
            {
                Authorization = new[] { new HangfireAuthorizationFilter() }
            });

            var manager = new RecurringJobManager();
            manager.AddOrUpdate<IRoundService>("Next round", (roundService) => roundService.NextRound(), Cron.Hourly());

            app.UseOpenApi();
            app.UseSwaggerUi3(config =>
            {
                config.OAuth2Client = new OAuth2ClientSettings
                {
                    ClientId = "undersea-swagger",
                    ClientSecret = null,
                    UsePkceWithAuthorizationCodeGrant = true,
                    ScopeSeparator = " ",
                    Realm = null,
                    AppName = "UnderSea Swagger Client"
                };
            });

            app.UseRouting();
            app.UseIdentityServer();

            app.UseProblemDetails();

            app.UseAuthentication();
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

        private void ConfigureProblemDetails(ProblemDetailsOptions options)
        {
            options.IncludeExceptionDetails = (ctx, ex) => false;

            options.Map<InvalidParameterException>(
              (ctx, ex) =>
              {
                  var pd = new ErrorBodyProblemDetails();
                  pd.Status = 400;
                  pd.Title = "Bad request (400)";
                  pd.Errors = ex.Errors;
                  return pd;
              }
              );

            options.Map<ArgumentOutOfRangeException>(
              (ctx, ex) =>
              {
                  var errors = new List<string>();
                  errors.Add(ex.Message);
                  var dict = new Dictionary<string, ICollection<string>>();
                  dict.Add(ex.ParamName, errors);
                  var pd = new ErrorBodyProblemDetails();
                  pd.Status = 400;
                  pd.Title = "Bad request (400)";
                  pd.Errors = dict;
                  return pd;
              }
              );

            options.Map<NotExistsException>(
              (ctx, ex) =>
              {
                  var pd = StatusCodeProblemDetails.Create(StatusCodes.Status401Unauthorized);
                  pd.Title = ex.Message;
                  return pd;
              }
              );
        }

    }
}
