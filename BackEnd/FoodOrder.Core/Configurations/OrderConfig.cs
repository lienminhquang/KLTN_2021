using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FoodOrder.Core.Configurations
{
    public class OrderConfig : IEntityTypeConfiguration<Order>
    {
        public void Configure(EntityTypeBuilder<Order> builder)
        {
            builder.ToTable("Order");
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).UseIdentityColumn();
            builder.Property(x => x.IsPaid).IsRequired().HasDefaultValue(false);

            builder.Property(x => x.AddressString).IsRequired().IsUnicode();
            builder.Property(x => x.AddressName).IsRequired().IsUnicode();
            builder.Property(x => x.FinalTotalPrice).IsRequired().HasDefaultValue(0);

            builder.HasMany(x => x.OrderDetails).WithOne(x => x.Order).HasForeignKey(x => x.OrderID);

            builder.Property(x => x.IsDeleted).IsRequired(true).HasDefaultValue(false);
            builder.Property(x => x.TimeDeleted).IsRequired(false);
        }
    }
}
