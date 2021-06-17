using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class ReplaceFirstName_Lastname_with_Name : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "FirstName",
                table: "AppUser");

            migrationBuilder.RenameColumn(
                name: "LastName",
                table: "AppUser",
                newName: "Name");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 11, 12, 26, 59, 11, DateTimeKind.Local).AddTicks(1949),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 10, 17, 43, 39, 130, DateTimeKind.Local).AddTicks(3780));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 11, 12, 26, 59, 12, DateTimeKind.Local).AddTicks(8278),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 10, 17, 43, 39, 132, DateTimeKind.Local).AddTicks(2864));

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Name",
                table: "AppUser",
                newName: "LastName");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 10, 17, 43, 39, 130, DateTimeKind.Local).AddTicks(3780),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 11, 12, 26, 59, 11, DateTimeKind.Local).AddTicks(1949));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 10, 17, 43, 39, 132, DateTimeKind.Local).AddTicks(2864),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 11, 12, 26, 59, 12, DateTimeKind.Local).AddTicks(8278));

            migrationBuilder.AddColumn<string>(
                name: "FirstName",
                table: "AppUser",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);

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
                columns: new[] { "ConcurrencyStamp", "FirstName", "PasswordHash" },
                values: new object[] { "a9151802-cb80-41ba-9865-9e78dc5b3764", "Mary", "AQAAAAEAACcQAAAAECO6oLP4QPFgckIP+iZZc4VOAI62PF7kpSpP4srurSTchTqvsLbrqlKF+rWJNutfNQ==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "FirstName", "PasswordHash" },
                values: new object[] { "62d1d1ff-a3bd-44b2-a411-977d69d01389", "Lonen", "AQAAAAEAACcQAAAAEHxYg4AoON4i1HwumFTXOs/Tv+7cqPayp5jAc2t4npMWSL/pq25gJNofPnbKTjUhfg==" });

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
    }
}
