using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FoodOrder.Core.Configurations
{
    public class OrderDetailConfig : IEntityTypeConfiguration<OrderDetail>
    {
        public void Configure(EntityTypeBuilder<OrderDetail> builder)
        {
            builder.ToTable("OrderDetail");
            builder.HasKey(x => new { x.OrderID, x.FoodID });
            builder.Property(x => x.Amount).IsRequired().HasDefaultValue(1);
            builder.Property(x => x.Price).IsRequired();

            builder.Property(x => x.IsDeleted).IsRequired(true).HasDefaultValue(false);
            builder.Property(x => x.TimeDeleted).IsRequired(false);
        }
    }
}
