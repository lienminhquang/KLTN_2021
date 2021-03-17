using FoodOrderBackend.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrderBackend.Configurations
{
    public class FoodCategoryConfig : IEntityTypeConfiguration<FoodCategory>
    {
        public void Configure(EntityTypeBuilder<FoodCategory> builder)
        {
            builder.ToTable("FoodCategory");
            builder.HasKey(x => new { x.FoodID, x.CategoryID });

            // TODO: Is this needed?
            //builder.HasOne(x => x.Food).WithMany(x => x.FoodCategories).HasForeignKey(x => x.FoodID);
        }
    }
}
