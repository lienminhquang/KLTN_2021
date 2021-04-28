using FoodOrder.Core.Models;
using FoodOrder.Data.Configurations;
using FoodOrder.Data.Extentions;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;

namespace FoodOrder.Data
{
    public class ApplicationDBContext : IdentityDbContext<AppUser, AppRole, Guid>
    {
        public ApplicationDBContext(DbContextOptionsBuilder options) => options.UseSqlServer();


        public ApplicationDBContext(DbContextOptions<ApplicationDBContext> options)
            : base(options)
        {

        }
        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            builder.ApplyConfiguration(new AppRoleConfig());
            builder.ApplyConfiguration(new AppUserConfig());
            builder.ApplyConfiguration(new CartConfig());
            builder.ApplyConfiguration(new CategoryConfig());
            builder.ApplyConfiguration(new FoodCategoryConfig());
            builder.ApplyConfiguration(new FoodConfig());
            builder.ApplyConfiguration(new ImageConfig());
            builder.ApplyConfiguration(new OrderConfig());
            builder.ApplyConfiguration(new OrderDetailConfig());
            builder.ApplyConfiguration(new OrderStatusConfig());
            builder.ApplyConfiguration(new PromotionConfig());
            builder.ApplyConfiguration(new RatingConfig());

            // config Identity
            builder.Entity<IdentityUserClaim<Guid>>().ToTable("AppUserClaim").HasKey(x => x.Id);
            builder.Entity<IdentityUserLogin<Guid>>().ToTable("AppUserLogin").HasKey(x => x.UserId);
            builder.Entity<IdentityUserRole<Guid>>().ToTable("AppUserRole").HasKey(x => new { x.UserId, x.RoleId });
            builder.Entity<IdentityUserToken<Guid>>().ToTable("AppUserToken").HasKey(x => x.UserId);
            builder.Entity<IdentityRoleClaim<Guid>>().ToTable("AppRoleClaim");

            builder.Seed();
        }

        public DbSet<AppRole> AppRoles { get; set; }
        public DbSet<AppUser> AppUsers { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Food> Foods { get; set; }
        public DbSet<FoodCategory> FoodCategories { get; set; }
        public DbSet<Image> Images { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }
        public DbSet<OrderStatus> OrderStatuses { get; set; }
        public DbSet<Promotion> Promotions { get; set; }
        public DbSet<Rating> Rating { get; set; }
    }
}
