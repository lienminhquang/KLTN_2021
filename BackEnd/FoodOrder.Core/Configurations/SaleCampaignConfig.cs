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
    public class SaleCampaignConfig : IEntityTypeConfiguration<SaleCampaign>
    {
        public void Configure(EntityTypeBuilder<SaleCampaign> builder)
        {
            builder.ToTable("SaleCampaign");
            builder.Property(x => x.ID).UseIdentityColumn();
            builder.HasKey(x => x.ID);
            builder.Property(x => x.Name).IsUnicode().IsRequired();
            builder.Property(x => x.Desciption).IsUnicode().IsRequired();
            builder.Property(x => x.Enabled).IsRequired();
            builder.Property(x => x.StartDate).IsRequired();
            builder.Property(x => x.EndDate).IsRequired();
            builder.Property(x => x.Percent).IsRequired();
            builder.Property(x => x.Priority).IsRequired();
        }
    }
}
