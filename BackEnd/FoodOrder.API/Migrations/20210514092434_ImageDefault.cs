using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class ImageDefault : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 695, DateTimeKind.Local).AddTicks(8859),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 994, DateTimeKind.Local).AddTicks(3609));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 695, DateTimeKind.Local).AddTicks(9290),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 994, DateTimeKind.Local).AddTicks(4039));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 694, DateTimeKind.Local).AddTicks(3584),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 993, DateTimeKind.Local).AddTicks(399));

            migrationBuilder.AddColumn<bool>(
                name: "IsDefault",
                table: "Image",
                type: "bit",
                nullable: false,
                defaultValue: false);

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsDefault",
                table: "Image");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 994, DateTimeKind.Local).AddTicks(3609),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 695, DateTimeKind.Local).AddTicks(8859));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 994, DateTimeKind.Local).AddTicks(4039),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 695, DateTimeKind.Local).AddTicks(9290));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 993, DateTimeKind.Local).AddTicks(399),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 14, 16, 24, 32, 694, DateTimeKind.Local).AddTicks(3584));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "cea8afc0-e182-42db-b32b-9dc4a52258d8");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "705fc5e9-65f4-4867-83d3-1d066d168b4b");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "70b0a433-7adf-4ac8-95a8-fbd2a9ebc294", "AQAAAAEAACcQAAAAECoDCxMrEAtZr36UPVhDAyXqL3aDHZXl7uohb0KonCilWBZzxa2bgspMGl1vqo9mdQ==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "38e54556-ed53-444b-b745-c373f7f27bff", "AQAAAAEAACcQAAAAEKIxvbAjRvfEieJoDq63czHrlS5FnmfoMkrYTmAbrunaC+TfqS1oHSpi1SVqm60GWw==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 3, 18, 23, 55, 57, 56, DateTimeKind.Local).AddTicks(1466));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 3, 18, 23, 55, 57, 57, DateTimeKind.Local).AddTicks(3767), new DateTime(2021, 3, 18, 23, 55, 57, 57, DateTimeKind.Local).AddTicks(7357) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 3, 18, 23, 55, 57, 58, DateTimeKind.Local).AddTicks(1060));
        }
    }
}
