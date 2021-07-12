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
    public class AddressConfig: IEntityTypeConfiguration<Address>
    {
        public void Configure(EntityTypeBuilder<Address> builder)
        {
            builder.ToTable("Address");
            builder.HasKey(x => new { x.ID });
            builder.Property(x => x.ID).UseIdentityColumn();
            builder.Property(x => x.AppUserID).IsRequired();
            builder.Property(x => x.Name).IsRequired();
            builder.Property(x => x.AddressString).IsRequired();
        }
    }
}
