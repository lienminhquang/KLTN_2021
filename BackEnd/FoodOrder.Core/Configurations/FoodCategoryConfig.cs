using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FoodOrder.Core.Configurations
{
    public class FoodCategoryConfig : IEntityTypeConfiguration<FoodCategory>
    {
        public void Configure(EntityTypeBuilder<FoodCategory> builder)
        {
            builder.ToTable("FoodCategory");
            builder.HasKey(x => new { x.FoodID, x.CategoryID });

            // TODO: Is this needed?
            //builder.HasOne(x => x.Food).WithMany(x => x.FoodCategories).HasForeignKey(x => x.FoodID);
            builder.Property(x => x.IsDeleted).IsRequired(true).HasDefaultValue(false);
            builder.Property(x => x.TimeDeleted).IsRequired(false);
        }
    }
}
