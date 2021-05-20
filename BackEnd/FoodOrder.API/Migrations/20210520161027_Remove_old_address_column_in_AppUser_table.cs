using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Remove_old_address_column_in_AppUser_table : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Address",
                table: "AppUser");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 180, DateTimeKind.Local).AddTicks(9051),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 438, DateTimeKind.Local).AddTicks(315));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 180, DateTimeKind.Local).AddTicks(9341),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 438, DateTimeKind.Local).AddTicks(579));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 179, DateTimeKind.Local).AddTicks(6199),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 436, DateTimeKind.Local).AddTicks(9152));

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 438, DateTimeKind.Local).AddTicks(315),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 180, DateTimeKind.Local).AddTicks(9051));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 438, DateTimeKind.Local).AddTicks(579),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 180, DateTimeKind.Local).AddTicks(9341));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 436, DateTimeKind.Local).AddTicks(9152),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 10, 26, 179, DateTimeKind.Local).AddTicks(6199));

            migrationBuilder.AddColumn<string>(
                name: "Address",
                table: "AppUser",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "e5945567-7d52-495a-9869-bcafb1d696af");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "e261311d-2263-4dfc-8adc-bc6450e0ed38");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "f2961ad3-5708-4e1d-b3a7-85ee5c7b82c8", "AQAAAAEAACcQAAAAEJRd2fM1wfWGN72IiH4wVcr1lA5IZNndFkEdM6kj60ZVgQIYCPhbQwlgm7PooETtyg==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "9c7ef7d7-f829-4ba7-bcdc-c5126536b20b", "AQAAAAEAACcQAAAAECxiHmbuSSrK689ncVvIiebimv1aB7ileGRsoT9LAALJb9fMT6gN+INL9H6dkS3Cdw==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 20, 23, 5, 15, 464, DateTimeKind.Local).AddTicks(1623));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 5, 20, 23, 5, 15, 465, DateTimeKind.Local).AddTicks(413), new DateTime(2021, 5, 20, 23, 5, 15, 465, DateTimeKind.Local).AddTicks(2944) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 20, 23, 5, 15, 465, DateTimeKind.Local).AddTicks(5355));
        }
    }
}
