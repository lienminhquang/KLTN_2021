﻿using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FoodOrder.Data.Configurations
{
    public class RatingConfig : IEntityTypeConfiguration<Rating>
    {
        public void Configure(EntityTypeBuilder<Rating> builder)
        {
            builder.ToTable("Rating");
            builder.HasKey(x => new { x.AppUserID, x.FoodID });
            builder.Property(x => x.Star).IsRequired().HasDefaultValue(5);
        }
    }
}