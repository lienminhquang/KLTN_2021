using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.Configurations
{
    public class SaleCampaignFoodConfig : IEntityTypeConfiguration<SaleCampaignFood>
    {
        public void Configure(EntityTypeBuilder<SaleCampaignFood> builder)
        {
            builder.ToTable("SaleCampaignFood");
            builder.HasKey(x => new { x.FoodID, x.SaleCampaignID });
        }
    }
}
