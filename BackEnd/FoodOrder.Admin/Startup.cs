using FluentValidation.AspNetCore;
using FoodOrder.Admin.Identity;
using FoodOrder.Admin.Services;
using FoodOrder.Core.AutoMapper;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels.Users;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace FoodOrder.Admin
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
            services.AddControllersWithViews()
                .AddFluentValidation(fv => fv.RegisterValidatorsFromAssemblyContaining<LoginRequestValidator>());
            //services.AddSession(op =>
            //{
            //    op.IdleTimeout = TimeSpan.FromMinutes(30);
            //});

            services.AddAutoMapper(typeof(AutoMapperProfile).Assembly);

            services.AddHttpClient();
            

            services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
                .AddCookie(options =>
                {
                    options.LoginPath = "/user/login";
                    options.AccessDeniedPath = "/user/forbidden";
                });

            services.AddAuthorization(options =>
            {
                options.AddPolicy(RoleTypes.Admin, policy => policy.RequireRole(RoleTypes.Admin));  
                options.AddPolicy(RoleTypes.Manager, policy => policy.RequireRole(RoleTypes.Manager));  
            });

            // DI
            services.AddSingleton<IAuthorizationHandler, CustomClaimHandler>();
            services.AddTransient<AdminUserService, AdminUserService>();
            services.AddTransient<AddressServices, AddressServices>();
            services.AddTransient<CartServices, CartServices>();
            services.AddTransient<CategoryServices, CategoryServices>();
            services.AddTransient<FoodServices, FoodServices>();
            services.AddTransient<OrderDetailServices, OrderDetailServices>();
            services.AddTransient<OrderServices, OrderServices>();
            services.AddTransient<OrderStatusServices, OrderStatusServices>();
            services.AddTransient<PromotionServices, PromotionServices>();
            services.AddTransient<RatingServices, RatingServices>();
            services.AddTransient<AppRoleServices, AppRoleServices>();
            //services.AddTransient<ImageServices, ImageServices>();
            services.AddTransient<NotificationServices, NotificationServices>();
            services.AddTransient<SaleCampaignServices, SaleCampaignServices>();
            services.AddTransient<HomeServices, HomeServices>();


            IMvcBuilder builder = services.AddRazorPages();
            var env = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
#if DEBUG
            if(env == "Development")
            {
                builder.AddRazorRuntimeCompilation();
            }
#endif
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                //app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseAuthentication();

            app.UseRouting();

            app.UseAuthorization();
            //app.UseSession();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
