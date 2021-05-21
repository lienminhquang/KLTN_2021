using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_Address_Info_to_order : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 773, DateTimeKind.Local).AddTicks(9980),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 180, DateTimeKind.Local).AddTicks(9051));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 774, DateTimeKind.Local).AddTicks(377),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 180, DateTimeKind.Local).AddTicks(9341));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 772, DateTimeKind.Local).AddTicks(5032),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 179, DateTimeKind.Local).AddTicks(6199));

            migrationBuilder.AddColumn<string>(
                name: "AddressName",
                table: "Order",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "AddressString",
                table: "Order",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "52668b2c-3f5b-4df2-9db7-764be06cce3a");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "eba1fd3c-8cb9-4d36-9566-c1fd680087aa");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "4d5874c9-c3a6-4c61-b732-dc929b4350f1", "AQAAAAEAACcQAAAAEKvBLaDgYy2+jYRDtT1IQpKnjrFw563hUq6z6P9184OVGnIyVmHFfkySH73zPs8nNw==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "da7efe52-9555-41d6-bf25-764122573d75", "AQAAAAEAACcQAAAAEPD8YI/9ltKUkms2k6Fx4HYQMFIgXuqrM2cNE30XvL7jSefFIiLXPtKIEjn8+NvqbA==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "AddressName", "AddressString", "CreatedDate" },
                values: new object[] { "Nha", "ABC", new DateTime(2021, 5, 21, 21, 50, 43, 810, DateTimeKind.Local).AddTicks(9936) });

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 5, 21, 21, 50, 43, 811, DateTimeKind.Local).AddTicks(9931), new DateTime(2021, 5, 21, 21, 50, 43, 812, DateTimeKind.Local).AddTicks(2495) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 21, 21, 50, 43, 812, DateTimeKind.Local).AddTicks(4988));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AddressName",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "AddressString",
                table: "Order");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 180, DateTimeKind.Local).AddTicks(9051),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 773, DateTimeKind.Local).AddTicks(9980));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 180, DateTimeKind.Local).AddTicks(9341),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 774, DateTimeKind.Local).AddTicks(377));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 179, DateTimeKind.Local).AddTicks(6199),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 772, DateTimeKind.Local).AddTicks(5032));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "d4639278-9863-4fbd-8308-3fbdd5720458");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "8d2af0a0-e0c9-4e49-b624-788f1325e419");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "221e5e81-4dfa-4919-bf32-a095688143ff", "AQAAAAEAACcQAAAAEKgy9YT8ItDWbYiFg71PC/F2j2o3V0uQqvEG3TFOmdxQ+qvWbhjEYxJQ50PWpPrIwA==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "d7522433-373e-4912-be40-8ca4aa6d7a3e", "AQAAAAEAACcQAAAAEHFfElchdfkzxwbqncBcBJjrVyn8Ih2FT0dmwh9QCuVh3HKjsu/godnBVF8gvmpQOQ==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 20, 23, 10, 26, 207, DateTimeKind.Local).AddTicks(4494));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 5, 20, 23, 10, 26, 208, DateTimeKind.Local).AddTicks(3635), new DateTime(2021, 5, 20, 23, 10, 26, 208, DateTimeKind.Local).AddTicks(6206) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 20, 23, 10, 26, 208, DateTimeKind.Local).AddTicks(8841));
        }
    }
}
