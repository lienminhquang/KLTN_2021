using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_FinalPrice_column_to_Order_for_statistic_Purpose : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 8, 22, 41, 49, 422, DateTimeKind.Local).AddTicks(5347),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 3, 20, 30, 9, 310, DateTimeKind.Local).AddTicks(6966));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 8, 22, 41, 49, 423, DateTimeKind.Local).AddTicks(6183),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 3, 20, 30, 9, 312, DateTimeKind.Local).AddTicks(6471));

            migrationBuilder.AddColumn<double>(
                name: "FinalTotalPrice",
                table: "Order",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "69564adf-db60-44d5-8a92-392744a44cee");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "0688db9b-eac9-4cd1-9273-e8a34363e1df");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "50149708-8e37-4319-8cca-b7436706d4f7");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "a3192100-e7f7-4caa-9a56-7389847da0d6", "AQAAAAEAACcQAAAAENc5gMBITetNgUbKL5EV2sLblX1mB89EVPkuZ+aeAAe+MJ1AJ4T/uT2VdperuRQWvA==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "11112fd9-7449-4f82-b024-f53ce8d21a44", "AQAAAAEAACcQAAAAEJaG7V9iPY49DCfTlBl/x7Lx06ny8JUDVydXm4Qz3ey7C0H3ciR4z/MMdsQFi0RBcw==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 8, 22, 41, 49, 462, DateTimeKind.Local).AddTicks(3071));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 8, 22, 41, 49, 463, DateTimeKind.Local).AddTicks(5266));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "FinalTotalPrice",
                table: "Order");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 3, 20, 30, 9, 310, DateTimeKind.Local).AddTicks(6966),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 8, 22, 41, 49, 422, DateTimeKind.Local).AddTicks(5347));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 3, 20, 30, 9, 312, DateTimeKind.Local).AddTicks(6471),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 8, 22, 41, 49, 423, DateTimeKind.Local).AddTicks(6183));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "6682e8eb-cf7a-4a54-a8ee-9fe4cb3c5d71");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "2445637a-03ac-49af-94c9-6f3d4d368b81");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "ad20edcb-1450-4354-a88a-69df305bff67");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "0acebcc0-bfb6-46a9-95e9-834ee41e72dd", "AQAAAAEAACcQAAAAEOhk1dlxZ08l0AWfJbClIC6TQLriDZ72NoHmn9MODLwaox3NMFSLdfJkqnzKmueKWw==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "7bfa3ab3-5d20-4060-bef1-638297e87e2f", "AQAAAAEAACcQAAAAEJSJFg9Wa9X/y0PGThMzcY0ZjWRLXr74k4uPoqjVY5uFRyktzdcRYveLVSTnSRHngg==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 3, 20, 30, 9, 381, DateTimeKind.Local).AddTicks(8190));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 3, 20, 30, 9, 384, DateTimeKind.Local).AddTicks(1440));
        }
    }
}
