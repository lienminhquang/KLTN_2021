using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class AddImagePathToFood : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 15, 22, 57, 9, 555, DateTimeKind.Local).AddTicks(8247),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 695, DateTimeKind.Local).AddTicks(8859));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 15, 22, 57, 9, 555, DateTimeKind.Local).AddTicks(8861),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 695, DateTimeKind.Local).AddTicks(9290));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 15, 22, 57, 9, 554, DateTimeKind.Local).AddTicks(5783),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 694, DateTimeKind.Local).AddTicks(3584));

            migrationBuilder.AddColumn<string>(
                name: "ImagePath",
                table: "Food",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "9f90f63c-297b-407a-9706-91342c0450bf");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "56b3207f-404d-4fcb-a868-a86ca8349f2c");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "d2bc6d39-b5fd-44ab-b723-e8ed4daffa5c", "AQAAAAEAACcQAAAAECO8TZNVfM1A8GETFOsTfMaXL1E5C0ee7jML5QnO3HxgpI8rs6tAhCD3XigHCFS8MA==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "98483a4e-b223-40d8-9b8c-6de252b7d468", "AQAAAAEAACcQAAAAEM0MTjejMZUSZPxqry8jRFFjoXMgFdB/O+3Z+zFpP8L3kgMSiIu0HB6Z/wInsBTzPw==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 15, 22, 57, 9, 588, DateTimeKind.Local).AddTicks(7515));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 5, 15, 22, 57, 9, 589, DateTimeKind.Local).AddTicks(6516), new DateTime(2021, 5, 15, 22, 57, 9, 589, DateTimeKind.Local).AddTicks(9053) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 15, 22, 57, 9, 590, DateTimeKind.Local).AddTicks(1494));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ImagePath",
                table: "Food");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 695, DateTimeKind.Local).AddTicks(8859),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 15, 22, 57, 9, 555, DateTimeKind.Local).AddTicks(8247));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 695, DateTimeKind.Local).AddTicks(9290),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 15, 22, 57, 9, 555, DateTimeKind.Local).AddTicks(8861));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 694, DateTimeKind.Local).AddTicks(3584),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 15, 22, 57, 9, 554, DateTimeKind.Local).AddTicks(5783));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "c65b89ed-17a5-461d-ad7f-2c34fbeb69d3");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "ba4fadd6-1f2e-4bb2-89dc-c6dddd543609");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "2716b524-f977-4461-88b9-4c0bc1930449", "AQAAAAEAACcQAAAAEKjtAidzRZn+PGHea8QpHKQ9T/cFgE9ELZWK2+99J9Cg86fmhXIi+kwFGmYivAcYYg==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "5dfddb37-9eb7-40db-a655-4d6bc116675e", "AQAAAAEAACcQAAAAEAJFP6w2CSvRRFUpZ9cUw2DYWsJBnKCE8ivDlw3lgoy1jJv4LSzWq0vJNlQueX2CIQ==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 14, 16, 24, 32, 740, DateTimeKind.Local).AddTicks(885));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 5, 14, 16, 24, 32, 741, DateTimeKind.Local).AddTicks(5705), new DateTime(2021, 5, 14, 16, 24, 32, 741, DateTimeKind.Local).AddTicks(9292) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 14, 16, 24, 32, 742, DateTimeKind.Local).AddTicks(2857));
        }
    }
}
