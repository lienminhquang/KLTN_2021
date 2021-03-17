using FoodOrderBackend.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrderBackend.Configurations
{
    public class AppUserConfig : IEntityTypeConfiguration<AppUser>
    {
        public void Configure(EntityTypeBuilder<AppUser> builder)
        {
            builder.ToTable("AppUser");
            builder.HasKey(x => x.Id);
            builder.Property(x => x.FirstName).IsUnicode().HasMaxLength(100);
            builder.Property(x => x.LastName).IsUnicode().HasMaxLength(100).IsRequired();
            

            builder.HasMany(x => x.Orders).WithOne(x => x.AppUser).HasForeignKey(x => x.AppUserID);
            builder.HasMany(x => x.Ratings).WithOne(x => x.AppUser).HasForeignKey(x => x.AppUserID);
            builder.HasMany(x => x.Carts).WithOne(x => x.AppUser).HasForeignKey(x => x.AppUserId);
        }
    }
}
