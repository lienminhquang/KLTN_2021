﻿using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FoodOrder.Core.Configurations
{
    public class OrderStatusConfig : IEntityTypeConfiguration<OrderStatus>
    {
        public void Configure(EntityTypeBuilder<OrderStatus> builder)
        {
            builder.ToTable("OrderStatus");
            builder.Property(x => x.ID).UseIdentityColumn();
            builder.HasKey(x => x.ID);
            builder.Property(x => x.Name).IsRequired().IsUnicode().HasMaxLength(100);
            builder.Property(x => x.Description).IsUnicode().HasMaxLength(100);

            builder.Property(x => x.PNTitle).IsUnicode().HasDefaultValue("Title");
            builder.Property(x => x.PNBody).IsUnicode().HasDefaultValue("Body");

            builder.HasMany(x => x.Orders).WithOne(x => x.OrderStatus).HasForeignKey(x => x.OrderStatusID);
        }
    }
}
