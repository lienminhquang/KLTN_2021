using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_timeCreateJWT_to_user_to_validate_jwt : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 10, 17, 43, 39, 130, DateTimeKind.Local).AddTicks(3780),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 8, 22, 41, 49, 422, DateTimeKind.Local).AddTicks(5347));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 10, 17, 43, 39, 132, DateTimeKind.Local).AddTicks(2864),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 8, 22, 41, 49, 423, DateTimeKind.Local).AddTicks(6183));

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeCreateJWT",
                table: "AppUser",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "5830a8c6-3b4f-4477-b158-32d2b3735fc1");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "53171e9b-e169-411d-a806-2f752aa74bf6");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "a6ca45fc-8b0f-4743-8a93-c0328caf31d6");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "a9151802-cb80-41ba-9865-9e78dc5b3764", "AQAAAAEAACcQAAAAECO6oLP4QPFgckIP+iZZc4VOAI62PF7kpSpP4srurSTchTqvsLbrqlKF+rWJNutfNQ==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "62d1d1ff-a3bd-44b2-a411-977d69d01389", "AQAAAAEAACcQAAAAEHxYg4AoON4i1HwumFTXOs/Tv+7cqPayp5jAc2t4npMWSL/pq25gJNofPnbKTjUhfg==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 10, 17, 43, 39, 207, DateTimeKind.Local).AddTicks(2658));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 10, 17, 43, 39, 209, DateTimeKind.Local).AddTicks(7514));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "TimeCreateJWT",
                table: "AppUser");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 8, 22, 41, 49, 422, DateTimeKind.Local).AddTicks(5347),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 10, 17, 43, 39, 130, DateTimeKind.Local).AddTicks(3780));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 8, 22, 41, 49, 423, DateTimeKind.Local).AddTicks(6183),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 10, 17, 43, 39, 132, DateTimeKind.Local).AddTicks(2864));

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
    }
}
