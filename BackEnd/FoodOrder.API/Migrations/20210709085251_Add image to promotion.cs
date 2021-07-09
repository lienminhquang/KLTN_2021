using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Addimagetopromotion : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 9, 15, 52, 49, 771, DateTimeKind.Local).AddTicks(8641),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 26, 14, 9, 21, 762, DateTimeKind.Local).AddTicks(8373));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 9, 15, 52, 49, 773, DateTimeKind.Local).AddTicks(474),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 26, 14, 9, 21, 764, DateTimeKind.Local).AddTicks(531));

            migrationBuilder.AddColumn<string>(
                name: "ImagePath",
                table: "Promotion",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "default.png");

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
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ImagePath",
                table: "Promotion");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 26, 14, 9, 21, 762, DateTimeKind.Local).AddTicks(8373),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 9, 15, 52, 49, 771, DateTimeKind.Local).AddTicks(8641));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 26, 14, 9, 21, 764, DateTimeKind.Local).AddTicks(531),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 9, 15, 52, 49, 773, DateTimeKind.Local).AddTicks(474));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "52394018-f122-4ccd-aa33-9f75b5600b0d");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "72b73871-1cbb-440d-8dba-e9b93b298c9e");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "c84897d5-7fce-4268-9cca-ad83fdfcd22d");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "3148aba7-5071-4966-8ce5-eb97f3c85c9d", "AQAAAAEAACcQAAAAEIcyI9zWffkdH+s8+WEXgcxr6UgZRck5Lh7Coyrr218wFM+SV6g4zbjeeu4UACc9Mg==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "24f08308-e00c-4a7b-ba76-de5488061c3b", "AQAAAAEAACcQAAAAEKsdcsydcrH1SyBXM/wpAlTWPK3iCGzVeOvWP6vjwdTRPovc1ZBT3uEq0Z+qTeHcNg==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 26, 14, 9, 21, 800, DateTimeKind.Local).AddTicks(812));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 26, 14, 9, 21, 801, DateTimeKind.Local).AddTicks(3241));
        }
    }
}
