using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FoodOrder.Core.Configurations
{
    public class AppUserConfig : IEntityTypeConfiguration<AppUser>
    {
        public void Configure(EntityTypeBuilder<AppUser> builder)
        {
            builder.ToTable("AppUser");
            builder.HasKey(x => x.Id);
           // builder.Property(x => x.FirstName).IsUnicode().HasMaxLength(100);
            builder.Property(x => x.Name).IsUnicode().HasMaxLength(100).IsRequired();
            //builder.Property(x => x.IsBanned).IsRequired().HasDefaultValue(false);
            

            builder.HasMany(x => x.Orders).WithOne(x => x.AppUser).HasForeignKey(x => x.AppUserID);
            
            builder.HasMany(x => x.Carts).WithOne(x => x.AppUser).HasForeignKey(x => x.AppUserId);
            builder.HasMany(x => x.Addresses).WithOne(x => x.AppUser).HasForeignKey(x => x.AppUserID);
        }
    }
}
