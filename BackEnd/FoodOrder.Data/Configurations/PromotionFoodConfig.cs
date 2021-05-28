using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Data.Configurations
{
    public class PromotionFoodConfig : IEntityTypeConfiguration<PromotionFood>
    {
        public void Configure(EntityTypeBuilder<PromotionFood> builder)
        {
            builder.ToTable("PromotionFood");
            builder.HasKey(x => new { x.FoodID, x.PromotionID });
        }
    }
}
