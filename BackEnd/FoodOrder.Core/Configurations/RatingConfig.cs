using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FoodOrder.Core.Configurations
{
    public class RatingConfig : IEntityTypeConfiguration<Rating>
    {
        public void Configure(EntityTypeBuilder<Rating> builder)
        {
            builder.ToTable("Rating");
            builder.HasKey(x => new { x.OrderID, x.FoodID});
            builder.Property(x => x.Star).IsRequired().HasDefaultValue(5);
           
            builder.Property(x => x.FoodID).IsRequired();
            builder.Property(x => x.Comment).IsUnicode();
            builder.Property(x => x.TimeCreate).IsUnicode();
            builder.HasOne(x => x.Order).WithMany(y => y.Ratings).HasForeignKey(x => x.OrderID);
        }
    }
}
