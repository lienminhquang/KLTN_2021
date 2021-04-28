using FoodOrder.Core.Models;
using FoodOrder.Data;
using IdentityServer4.Models;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography.X509Certificates;
using static FoodOrder.IdentityServer.Config;

namespace FoodOrder.IdentityServer
{
    public class Startup
    {

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {

            //services.

            services.AddDbContext<ApplicationDBContext>(opt => opt.UseSqlServer(Configuration.GetConnectionString("FoodOrderDatabase")));
            services.AddIdentity<AppUser, AppRole>()
                .AddEntityFrameworkStores<ApplicationDBContext>(); ;
            

            services.AddIdentityServer()
                .AddSigningCredential(new X509Certificate2(Path.Combine(".", "certs", "IdentityServer4Auth.pfx")))
                .AddInMemoryClients(Clients.Get())
                .AddInMemoryIdentityResources(Config.Resources.GetIdentityResources())
                .AddInMemoryApiScopes(Config.Resources.GetApiScopes())
                .AddInMemoryApiResources(Config.Resources.GetApiResources())
                //.AddTestUsers(Users.Get())
                //.AddDeveloperSigningCredential()
                .AddAspNetIdentity<AppUser>();

            // add swagger
            services.AddControllers().AddNewtonsoftJson(opt => opt.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);
            services.AddSwaggerGen();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.UseSwagger();
            app.UseSwaggerUI(
                c =>
                {
                    c.SwaggerEndpoint("/swagger/v1/swagger.json", "My IDENTITY SERVER");
                }
                );

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseAuthentication();
            app.UseRouting();

            app.UseIdentityServer();

        }
    }
}
