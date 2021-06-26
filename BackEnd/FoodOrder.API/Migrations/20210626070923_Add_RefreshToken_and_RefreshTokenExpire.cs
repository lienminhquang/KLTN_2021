using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_RefreshToken_and_RefreshTokenExpire : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 26, 14, 9, 21, 762, DateTimeKind.Local).AddTicks(8373),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 11, 12, 26, 59, 11, DateTimeKind.Local).AddTicks(1949));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 26, 14, 9, 21, 764, DateTimeKind.Local).AddTicks(531),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 11, 12, 26, 59, 12, DateTimeKind.Local).AddTicks(8278));

            migrationBuilder.AddColumn<string>(
                name: "RefreshToken",
                table: "AppUser",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "RefreshTokenExpire",
                table: "AppUser",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "RefreshToken",
                table: "AppUser");

            migrationBuilder.DropColumn(
                name: "RefreshTokenExpire",
                table: "AppUser");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 11, 12, 26, 59, 11, DateTimeKind.Local).AddTicks(1949),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 26, 14, 9, 21, 762, DateTimeKind.Local).AddTicks(8373));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 11, 12, 26, 59, 12, DateTimeKind.Local).AddTicks(8278),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 26, 14, 9, 21, 764, DateTimeKind.Local).AddTicks(531));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "65e2c623-4774-4971-9069-c0ced2ce15db");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "b1d35fd3-a507-4bf1-94c4-e60ff76bfbe6");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "374fbb46-3e0a-4001-90e7-aa7751217955");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "31ca2c13-d0f1-4835-8dcf-6227da4ed40a", "AQAAAAEAACcQAAAAEP7wi8ng70Ppz6nhmfRiyYv96iapxDuWCkTxpunqkufa0bBntxf+760xnaLciIq3fw==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "5b744150-e9d5-4b3a-80eb-614c5bcbc59f", "AQAAAAEAACcQAAAAEPe+ZiqU9A4zSQY0Hawqhi9G+SKY4oLvav///hcsTiR9RVmD565+nJiLbc/YwZNhTA==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 11, 12, 26, 59, 83, DateTimeKind.Local).AddTicks(5271));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 11, 12, 26, 59, 85, DateTimeKind.Local).AddTicks(6311));
        }
    }
}
