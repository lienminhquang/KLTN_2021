using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_PN_Info_For_OrderStatus : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 17, 19, 32, 8, 632, DateTimeKind.Local).AddTicks(2687),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 12, 14, 47, 53, 996, DateTimeKind.Local).AddTicks(2564));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 17, 19, 32, 8, 633, DateTimeKind.Local).AddTicks(5298),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 12, 14, 47, 53, 997, DateTimeKind.Local).AddTicks(7324));

            migrationBuilder.AddColumn<string>(
                name: "PNBody",
                table: "OrderStatus",
                type: "nvarchar(max)",
                nullable: true,
                defaultValue: "Body");

            migrationBuilder.AddColumn<string>(
                name: "PNTitle",
                table: "OrderStatus",
                type: "nvarchar(max)",
                nullable: true,
                defaultValue: "Title");

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PNBody",
                table: "OrderStatus");

            migrationBuilder.DropColumn(
                name: "PNTitle",
                table: "OrderStatus");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 12, 14, 47, 53, 996, DateTimeKind.Local).AddTicks(2564),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 17, 19, 32, 8, 632, DateTimeKind.Local).AddTicks(2687));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 7, 12, 14, 47, 53, 997, DateTimeKind.Local).AddTicks(7324),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 7, 17, 19, 32, 8, 633, DateTimeKind.Local).AddTicks(5298));

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
    }
}
