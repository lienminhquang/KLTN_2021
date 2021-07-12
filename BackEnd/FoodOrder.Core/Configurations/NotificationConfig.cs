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
    public class NotificationConfig : IEntityTypeConfiguration<Notification>
    {
        public void Configure(EntityTypeBuilder<Notification> builder)
        {
            builder.ToTable("Notification");
            builder.HasKey(x => new { x.ID });
            builder.Property(x => x.ID).UseIdentityColumn();
            builder.Property(x => x.Title).IsRequired().IsUnicode();
            builder.Property(x => x.Message).IsRequired().IsUnicode();
            builder.Property(x => x.Type).IsRequired();
            builder.Property(x => x.TimeCreated).IsRequired();
            builder.Property(x => x.UserReceived).IsRequired();

            builder.HasOne(x => x.AppUser).WithMany(user => user.Notifications).HasForeignKey(a => a.UserID);
        }
    }
}
