using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_Delete_Field_For_Entity : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Image");

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "SaleCampaignFood",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "SaleCampaignFood",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "SaleCampaign",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "SaleCampaign",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "Rating",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "Rating",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 12, 14, 47, 53, 996, DateTimeKind.Local).AddTicks(2564),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 9, 15, 52, 49, 771, DateTimeKind.Local).AddTicks(8641));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 12, 14, 47, 53, 997, DateTimeKind.Local).AddTicks(7324),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 9, 15, 52, 49, 773, DateTimeKind.Local).AddTicks(474));

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "Promotion",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "Promotion",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "OrderDetail",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "OrderDetail",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "Order",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "Order",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "Notification",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "Notification",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "FoodCategory",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "FoodCategory",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "Food",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "Food",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "Category",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "Category",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "AppUser",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "AppUser",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "AppRole",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "AppRole",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsDeleted",
                table: "Address",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeDeleted",
                table: "Address",
                type: "datetime2",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "235a3125-d734-4655-916e-7c2ddc8f1b2d");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "291213c2-b75c-4c93-ae7a-467383587728");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "118a9f9d-dc51-49a6-ab0d-3ad0eeca4488");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "8762c19d-97e0-4fe6-b84c-f5c645952e8f", "AQAAAAEAACcQAAAAEG8dtPLg+U6aUE9yIPco+EPIGYqP/O/e4dLv1PHNjCCnK7vjdrajxLRfNR7zkRQIoA==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "c8e22d8f-3315-43b8-99ea-880d1dbfd2e3", "AQAAAAEAACcQAAAAEIHmT9jZM9GsH/1SakDhajrh/dOxVPLxzzTpxZ24IrTZUW99LCWtpjyfzqvnmrvi5A==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 7, 12, 14, 47, 54, 48, DateTimeKind.Local).AddTicks(2077));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 7, 12, 14, 47, 54, 50, DateTimeKind.Local).AddTicks(46));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "SaleCampaignFood");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "SaleCampaignFood");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "SaleCampaign");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "SaleCampaign");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "Rating");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "Rating");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "Promotion");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "Promotion");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "OrderDetail");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "OrderDetail");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "Notification");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "Notification");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "FoodCategory");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "FoodCategory");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "Food");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "Food");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "Category");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "Category");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "AppUser");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "AppUser");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "AppRole");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "AppRole");

            migrationBuilder.DropColumn(
                name: "IsDeleted",
                table: "Address");

            migrationBuilder.DropColumn(
                name: "TimeDeleted",
                table: "Address");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 9, 15, 52, 49, 771, DateTimeKind.Local).AddTicks(8641),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 12, 14, 47, 53, 996, DateTimeKind.Local).AddTicks(2564));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 9, 15, 52, 49, 773, DateTimeKind.Local).AddTicks(474),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 12, 14, 47, 53, 997, DateTimeKind.Local).AddTicks(7324));

            migrationBuilder.CreateTable(
                name: "Image",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Caption = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    FoodID = table.Column<int>(type: "int", nullable: false),
                    ImagePath = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsDefault = table.Column<bool>(type: "bit", nullable: false),
                    SortOrder = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Image", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Image_Food_FoodID",
                        column: x => x.FoodID,
                        principalTable: "Food",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "29152590-1c28-411d-b95f-b8a116122b28");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "cd0a9890-b483-454d-a4ab-8903096d325f");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "9dae75d5-577c-4371-ad6b-eb859ddbe63d");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "bd9b5231-bc90-46d5-a6f9-72bc973a805b", "AQAAAAEAACcQAAAAEKUaXSX3XZtnzRDSlbUIV1HJ86qUmvDb1wCLpuJnG4eFUDe3uZsaMowVg2LA9ecakA==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "00617e99-9681-46f2-abb5-3babcc6fd129", "AQAAAAEAACcQAAAAECxYRre80fAVfM1rFQDQRe+u1QZR8bwufpYKPOObFEG5Ho4tGUY4GQSuNrLyyH30xg==" });

            migrationBuilder.InsertData(
                table: "Image",
                columns: new[] { "ID", "Caption", "FoodID", "ImagePath", "IsDefault", "SortOrder" },
                values: new object[,]
                {
                    { 1, "", 1, "default.png", false, 1 },
                    { 2, "", 2, "default.png", false, 1 },
                    { 3, "", 3, "default.png", false, 1 },
                    { 4, "", 4, "default.png", false, 1 }
                });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 7, 9, 15, 52, 49, 809, DateTimeKind.Local).AddTicks(2578));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 7, 9, 15, 52, 49, 810, DateTimeKind.Local).AddTicks(6373));

            migrationBuilder.CreateIndex(
                name: "IX_Image_FoodID",
                table: "Image",
                column: "FoodID");
        }
    }
}
