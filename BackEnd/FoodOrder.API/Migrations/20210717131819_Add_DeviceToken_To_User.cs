using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_DeviceToken_To_User : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 17, 20, 18, 18, 406, DateTimeKind.Local).AddTicks(2913),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 17, 19, 32, 8, 632, DateTimeKind.Local).AddTicks(2687));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 17, 20, 18, 18, 407, DateTimeKind.Local).AddTicks(9337),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 17, 19, 32, 8, 633, DateTimeKind.Local).AddTicks(5298));

            migrationBuilder.AddColumn<string>(
                name: "DeviceToken",
                table: "AppUser",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "5cdb4e12-e83f-417d-8338-1ef96c899c03");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "aecd1b7f-6599-48f1-8063-5f3d55e6647c");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "9d481658-883d-46f6-b85c-b736763136a0");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "ae5cb6bc-2d0d-482a-8065-d6d7a8cbd211", "AQAAAAEAACcQAAAAEJzqEa82j2jCjIMqYXUSGAnZYKDQeA3vqJHXoYN0Yynw7NXdXfrTsnWjbOC4JsMpBQ==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "ae8e69c1-0d5d-49ce-9e1f-fd9429e0f094", "AQAAAAEAACcQAAAAEKUFYt1LRszxIIIssrFheZAkDfJPD/V5UnvaJQcHdY/hRK4Yn/IVapi3zsYoilRWDw==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 7, 17, 20, 18, 18, 461, DateTimeKind.Local).AddTicks(5068));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 7, 17, 20, 18, 18, 463, DateTimeKind.Local).AddTicks(5034));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DeviceToken",
                table: "AppUser");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 17, 19, 32, 8, 632, DateTimeKind.Local).AddTicks(2687),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 17, 20, 18, 18, 406, DateTimeKind.Local).AddTicks(2913));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 17, 19, 32, 8, 633, DateTimeKind.Local).AddTicks(5298),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 17, 20, 18, 18, 407, DateTimeKind.Local).AddTicks(9337));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "9dc28df3-9aa5-4f12-89bf-bca834e80699");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "e5b0589e-66e8-485a-9a8a-735f5788c565");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "0e20eb78-f2e6-421f-8431-5ca9f479a06b");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "b540acaf-2fe0-4f57-9122-2c0c2efcbf08", "AQAAAAEAACcQAAAAEIPxVBKF2vGs/eYX9faxMOn0mOgzzI1Vurh7gavkLyRtPe1w07ylXL+F4m2qV7nKjQ==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "9b4c16e8-7bae-431f-9aba-954ddc8dd90e", "AQAAAAEAACcQAAAAEOIsfMC9daTnJoHgI665i2DjsN/CMB37BG+dAvuj6VfPRlOi1vqmE48aC30GfwFADw==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 7, 17, 19, 32, 8, 669, DateTimeKind.Local).AddTicks(6196));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 7, 17, 19, 32, 8, 670, DateTimeKind.Local).AddTicks(8945));
        }
    }
}
