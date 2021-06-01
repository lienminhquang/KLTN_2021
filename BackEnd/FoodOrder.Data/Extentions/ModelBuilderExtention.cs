using FoodOrder.Core.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;

namespace FoodOrder.Data.Extentions
{
    public static class ModelBuilderExtention
    {
        public static void Seed(this ModelBuilder modelBuilder)
        {
            PasswordHasher<AppUser> passwordHasher = new PasswordHasher<AppUser>();
            string adminID = "B4E253B2-756E-48B8-9C42-B5ACB139BED4";
            string userID = "DAEB6F0D-EEFE-4250-9ECD-28B3243EB684";

            modelBuilder.Entity<AppUser>().HasData(
                new AppUser
                {
                    Id = new Guid(adminID),
                    FirstName = "Mary",
                    LastName = "Jame",
                    DateOfBirth = new DateTime(1999, 5, 21),
                    UserName = "admin",
                    PasswordHash = passwordHasher.HashPassword(null, "123456"),
                    Email = "jame@gmail.com",
                    NormalizedEmail = "JAME@GMAIL.COM",
                    PhoneNumber = "+111111111"
                },
                new AppUser
                {
                    Id = new Guid(userID),
                    FirstName = "Lonen",
                    LastName = "Messi",
                    DateOfBirth = new DateTime(1990, 7, 5),
                    UserName = "messi10",
                    PasswordHash = passwordHasher.HashPassword(null, "123456"),
                    Email = "messi10@gmail.com",
                    NormalizedEmail = "MESSI10@GMAIL.COM",
                    PhoneNumber = "+111111111"
                }
                );
            modelBuilder.Entity<AppRole>().HasData(
                new AppRole
                {
                    Id = new Guid("B9E08F48-883C-42DC-A700-DA5CF1D81AA3"),
                    Description = "This is Admintrator role.",
                    Name = "admin",
                    NormalizedName = "ADMIN"
                },
                new AppRole
                {
                    Id = new Guid("74D17D8B-3F91-4D3A-893F-09B4E51E3834"),
                    Description = "This is User role.",
                    Name = "user",
                    NormalizedName = "User"
                }
                );

            modelBuilder.Entity<Cart>().HasData(
                new Cart { AppUserId = new Guid(userID), FoodID = 1, Quantity = 1 },
                new Cart { AppUserId = new Guid(userID), FoodID = 2, Quantity = 2 }
                );
            modelBuilder.Entity<Category>().HasData(
                new Category { ID = 1, Description = "Com trua cac loai", Name = "Com trua" },
                new Category { ID = 2, Description = "Nuoc giai khat cac loai", Name = "Nuoc giai khat" },
                new Category { ID = 3, Description = "Mon an kem", Name = "Cac mon an kem mon chinh" }
                );
            modelBuilder.Entity<Food>().HasData(
                new Food { ID = 1, Name = "Com tam gia truyen", Description = "Com tam lam tu by quyet gia truyen co 2 khong 1", Price = 15000, Count = 100 },
                new Food { ID = 2, Name = "Canh rong bien", Description = "Canh rong bien thit bam", Price = 10000, Count = 57 },
                new Food { ID = 3, Name = "Pepsi", Description = "Nuoc giai khat pepsi",  Price = 7000, Count = 1000 },
                new Food { ID = 4, Name = "Tra da", Description = "Tra da lam tu by quyet gia truyen co 2 khong 1", Price = 5000, Count = 200 }
                );
            modelBuilder.Entity<Image>().HasData(
                new Image { ID = 1, Caption = "", FoodID = 1, ImagePath = "default.png", SortOrder = 1 },
                new Image { ID = 2, Caption = "", FoodID = 2, ImagePath = "default.png", SortOrder = 1 },
                new Image { ID = 3, Caption = "", FoodID = 3, ImagePath = "default.png", SortOrder = 1 },
                new Image { ID = 4, Caption = "", FoodID = 4, ImagePath = "default.png", SortOrder = 1 }
                );
            modelBuilder.Entity<FoodCategory>().HasData(
                new FoodCategory { CategoryID = 1, FoodID = 1 },
                new FoodCategory { CategoryID = 2, FoodID = 3 },
                new FoodCategory { CategoryID = 2, FoodID = 4 },
                new FoodCategory { CategoryID = 1, FoodID = 3 }
                );
            modelBuilder.Entity<Order>().HasData(
                new Order { ID = 1, AppUserID = new Guid(userID), CreatedDate = DateTime.Now, DatePaid = null, IsPaid = false, OrderStatusID = 1, PromotionID = 1 , AddressName = "Nha", AddressString = "ABC"}
                );
            modelBuilder.Entity<OrderDetail>().HasData(
                new OrderDetail { FoodID = 1, Amount = 1, OrderID = 1, Price = 12000 },
                new OrderDetail { FoodID = 3, Amount = 2, OrderID = 1, Price = 5000 }
                );
            modelBuilder.Entity<OrderStatus>().HasData(
                //new OrderStatus { ID = 1, Name = "Dang tiep nhan", Description = "" },
                new OrderStatus { ID = 2, Name = "Đang chuẩn bị", Description = "" },
                new OrderStatus { ID = 3, Name = "Đang giao hàng", Description = "" },
                new OrderStatus { ID = 4, Name = "Đã nhận hàng", Description = "" },
                new OrderStatus { ID = 5, Name = "Đã hủy", Description = "" }
                );
            modelBuilder.Entity<Promotion>().HasData(
                new Promotion { ID = 1, Name = "Chao thanh vien moi", UseTimes = 100, Code = "THANHVIENMOI", Enabled = true, EndDate = new DateTime(2022, 1, 1), Percent = 0.25f, MinPrice = 50000, Max = 5000, StartDate = DateTime.Now }
                );
            
        }
    }
}
