using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System.Linq;

namespace FoodOrder.Data.Configurations
{
    public class FoodConfig : IEntityTypeConfiguration<Food>
    {
        public void Configure(EntityTypeBuilder<Food> builder)
        {
            builder.ToTable("Food");
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).UseIdentityColumn();
            builder.Property(x => x.Name).IsRequired().IsUnicode().HasMaxLength(100);
            builder.Property(x => x.Description).IsRequired().IsUnicode().HasMaxLength(300);
            builder.Property(x => x.Price).IsRequired();
            builder.Property(x => x.Count).IsRequired().HasDefaultValue(0);

            builder.HasMany(x => x.OrderDetails).WithOne(x => x.Food).HasForeignKey(x => x.FoodID);
            builder.HasMany(x => x.Ratings).WithOne(x => x.Food).HasForeignKey(x => x.FoodID);
            builder.HasMany(x => x.FoodCategories).WithOne(x => x.Food).HasForeignKey(x => x.FoodID);
            builder.HasMany(x => x.Carts).WithOne(x => x.Food).HasForeignKey(x => x.FoodID);
            builder.HasMany(x => x.Images).WithOne(x => x.Food).HasForeignKey(x => x.FoodID);
        }
    }
}
