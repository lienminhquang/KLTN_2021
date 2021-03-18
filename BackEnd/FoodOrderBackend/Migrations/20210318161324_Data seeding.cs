using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrderBackend.Migrations
{
    public partial class Dataseeding : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Comment",
                table: "Rating",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "LastCreatedTime",
                table: "Rating",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 90, DateTimeKind.Local).AddTicks(1913),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 675, DateTimeKind.Local).AddTicks(1031));

            migrationBuilder.AlterColumn<float>(
                name: "Percent",
                table: "Promotion",
                type: "real",
                nullable: false,
                defaultValue: 10f,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)",
                oldDefaultValue: 10m);

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 90, DateTimeKind.Local).AddTicks(2539),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 675, DateTimeKind.Local).AddTicks(1533));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 88, DateTimeKind.Local).AddTicks(7532),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 673, DateTimeKind.Local).AddTicks(6249));

            migrationBuilder.AddColumn<int>(
                name: "Max",
                table: "Promotion",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "MinPrice",
                table: "Promotion",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AlterColumn<DateTime>(
                name: "DatePaid",
                table: "Order",
                type: "datetime2",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

            migrationBuilder.AddColumn<int>(
                name: "Count",
                table: "Food",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.InsertData(
                table: "AppRole",
                columns: new[] { "Id", "ConcurrencyStamp", "Description", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"), "64241348-79de-4b51-8da8-7da1a5c36308", "This is Admintrator role.", "admin", "ADMIN" },
                    { new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"), "16349281-f43a-4b61-9117-a507b9b3d13f", "This is User role.", "user", "User" }
                });

            migrationBuilder.InsertData(
                table: "AppUser",
                columns: new[] { "Id", "AccessFailedCount", "Address", "ConcurrencyStamp", "DateOfBirth", "Email", "EmailConfirmed", "FirstName", "LastName", "LockoutEnabled", "LockoutEnd", "NormalizedEmail", "NormalizedUserName", "PasswordHash", "PhoneNumber", "PhoneNumberConfirmed", "SecurityStamp", "TwoFactorEnabled", "UserName" },
                values: new object[,]
                {
                    { new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"), 0, null, "5b9c6899-30bd-4866-aeca-41f7091aa8e9", new DateTime(1999, 5, 21, 0, 0, 0, 0, DateTimeKind.Unspecified), "jame@gmail.com", false, "Mary", "Jame", false, null, "JAME@GMAIL.COM", null, "AQAAAAEAACcQAAAAEDV6OCinywMuR0BpXBQ2qCut24U8PrDJXajXWHnG/KLQeexWK2jSrMVXGHKSUucKUg==", "+111111111", false, null, false, "admin" },
                    { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 0, null, "359cb04b-be2b-4b52-bcba-d200648206c9", new DateTime(1990, 7, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "messi10@gmail.com", false, "Lonen", "Messi", false, null, "MESSI10@GMAIL.COM", null, "AQAAAAEAACcQAAAAEIyZFJ5btZRqQSTNr/H/ez4KjuwH1x/4Jct7G5KYFxw8AszbQerk/AM1A0ROc1UWZw==", "+111111111", false, null, false, "messi10" }
                });

            migrationBuilder.InsertData(
                table: "Category",
                columns: new[] { "ID", "Description", "Name" },
                values: new object[,]
                {
                    { 1, "Com trua cac loai", "Com trua" },
                    { 2, "Nuoc giai khat cac loai", "Nuoc giai khat" },
                    { 3, "Mon an kem", "Cac mon an kem mon chinh" }
                });

            migrationBuilder.InsertData(
                table: "Food",
                columns: new[] { "ID", "Count", "Description", "ImagePath", "Name", "Price" },
                values: new object[,]
                {
                    { 4, 200, "Tra da lam tu by quyet gia truyen co 2 khong 1", "default", "Tra da", 5000m },
                    { 3, 1000, "Nuoc giai khat pepsi", "default", "Pepsi", 7000m },
                    { 2, 57, "Canh rong bien thit bam", "default", "Canh rong bien", 10000m },
                    { 1, 100, "Com tam lam tu by quyet gia truyen co 2 khong 1", "default", "Com tam gia truyen", 15000m }
                });

            migrationBuilder.InsertData(
                table: "OrderStatus",
                columns: new[] { "ID", "Description", "Name" },
                values: new object[,]
                {
                    { 1, "", "Dang tiep nhan" },
                    { 2, "", "Dang chuan bi" },
                    { 3, "", "Dang giao hang" },
                    { 4, "", "Da nhan hang" },
                    { 5, "", "Da huy" }
                });

            migrationBuilder.InsertData(
                table: "Promotion",
                columns: new[] { "ID", "Amount", "Code", "CreatedDate", "Desciption", "Enabled", "EndDate", "Max", "MinPrice", "Name", "Percent", "StartDate" },
                values: new object[] { 1, 100, "THANHVIENMOI", new DateTime(2021, 3, 18, 23, 13, 23, 192, DateTimeKind.Local).AddTicks(9080), null, true, new DateTime(2022, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 5000, 50000, "Chao thanh vien moi", 0.25f, new DateTime(2021, 3, 18, 23, 13, 23, 193, DateTimeKind.Local).AddTicks(1832) });

            migrationBuilder.InsertData(
                table: "Cart",
                columns: new[] { "AppUserId", "FoodID", "Quantity" },
                values: new object[,]
                {
                    { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1, 1 },
                    { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 2, 2 }
                });

            migrationBuilder.InsertData(
                table: "FoodCategory",
                columns: new[] { "CategoryID", "FoodID" },
                values: new object[,]
                {
                    { 1, 1 },
                    { 2, 3 },
                    { 1, 3 },
                    { 2, 4 }
                });

            migrationBuilder.InsertData(
                table: "Order",
                columns: new[] { "ID", "AppUserID", "CreatedDate", "DatePaid", "OrderStatusID", "PromotionID" },
                values: new object[] { 1, new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), new DateTime(2021, 3, 18, 23, 13, 23, 191, DateTimeKind.Local).AddTicks(9527), null, 1, 1 });

            migrationBuilder.InsertData(
                table: "Rating",
                columns: new[] { "AppUserID", "FoodID", "Comment", "LastCreatedTime", "Star" },
                values: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1, "Good", new DateTime(2021, 3, 18, 23, 13, 23, 193, DateTimeKind.Local).AddTicks(4451), 5 });

            migrationBuilder.InsertData(
                table: "OrderDetail",
                columns: new[] { "FoodID", "OrderID", "Amount", "Price" },
                values: new object[] { 1, 1, 1, 12000m });

            migrationBuilder.InsertData(
                table: "OrderDetail",
                columns: new[] { "FoodID", "OrderID", "Amount", "Price" },
                values: new object[] { 3, 1, 2, 5000m });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"));

            migrationBuilder.DeleteData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"));

            migrationBuilder.DeleteData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"));

            migrationBuilder.DeleteData(
                table: "Cart",
                keyColumns: new[] { "AppUserId", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 });

            migrationBuilder.DeleteData(
                table: "Cart",
                keyColumns: new[] { "AppUserId", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 2 });

            migrationBuilder.DeleteData(
                table: "Category",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "FoodCategory",
                keyColumns: new[] { "CategoryID", "FoodID" },
                keyValues: new object[] { 1, 1 });

            migrationBuilder.DeleteData(
                table: "FoodCategory",
                keyColumns: new[] { "CategoryID", "FoodID" },
                keyValues: new object[] { 1, 3 });

            migrationBuilder.DeleteData(
                table: "FoodCategory",
                keyColumns: new[] { "CategoryID", "FoodID" },
                keyValues: new object[] { 2, 3 });

            migrationBuilder.DeleteData(
                table: "FoodCategory",
                keyColumns: new[] { "CategoryID", "FoodID" },
                keyValues: new object[] { 2, 4 });

            migrationBuilder.DeleteData(
                table: "OrderDetail",
                keyColumns: new[] { "FoodID", "OrderID" },
                keyValues: new object[] { 1, 1 });

            migrationBuilder.DeleteData(
                table: "OrderDetail",
                keyColumns: new[] { "FoodID", "OrderID" },
                keyValues: new object[] { 3, 1 });

            migrationBuilder.DeleteData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 });

            migrationBuilder.DeleteData(
                table: "Category",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Category",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"));

            migrationBuilder.DeleteData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DropColumn(
                name: "Comment",
                table: "Rating");

            migrationBuilder.DropColumn(
                name: "LastCreatedTime",
                table: "Rating");

            migrationBuilder.DropColumn(
                name: "Max",
                table: "Promotion");

            migrationBuilder.DropColumn(
                name: "MinPrice",
                table: "Promotion");

            migrationBuilder.DropColumn(
                name: "Count",
                table: "Food");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 675, DateTimeKind.Local).AddTicks(1031),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 90, DateTimeKind.Local).AddTicks(1913));

            migrationBuilder.AlterColumn<decimal>(
                name: "Percent",
                table: "Promotion",
                type: "decimal(18,2)",
                nullable: false,
                defaultValue: 10m,
                oldClrType: typeof(float),
                oldType: "real",
                oldDefaultValue: 10f);

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 675, DateTimeKind.Local).AddTicks(1533),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 90, DateTimeKind.Local).AddTicks(2539));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 673, DateTimeKind.Local).AddTicks(6249),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 88, DateTimeKind.Local).AddTicks(7532));

            migrationBuilder.AlterColumn<DateTime>(
                name: "DatePaid",
                table: "Order",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldNullable: true);
        }
    }
}
