using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;

namespace FoodOrder.Data.Configurations
{
    public class PromotionConfig : IEntityTypeConfiguration<Promotion>
    {
        public void Configure(EntityTypeBuilder<Promotion> builder)
        {
            builder.ToTable("Promotion");
            builder.Property(x => x.ID).UseIdentityColumn();
            builder.HasKey(x => x.ID);
            builder.Property(x => x.Name).IsRequired().IsUnicode().HasMaxLength(100);
            builder.Property(x => x.Code).IsRequired().HasMaxLength(50);
            builder.Property(x => x.Desciption).HasMaxLength(300);
            builder.Property(x => x.CreatedDate).IsRequired().HasDefaultValue(DateTime.Now);
            builder.Property(x => x.StartDate).IsRequired().HasDefaultValue(DateTime.Now);
            builder.Property(x => x.EndDate).IsRequired().HasDefaultValue(DateTime.Now);
            builder.Property(x => x.Enabled).IsRequired().HasDefaultValue(false);
            builder.Property(x => x.Amount).IsRequired();
            builder.Property(x => x.Percent).IsRequired().HasDefaultValue(10.0);

            builder.HasMany(x => x.Orders).WithOne(x => x.Promotion).HasForeignKey(x => x.PromotionID);
        }
    }
}
