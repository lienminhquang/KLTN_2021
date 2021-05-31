using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Use_double_for_currency : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 31, 9, 59, 21, 240, DateTimeKind.Local).AddTicks(8275),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 31, 9, 8, 36, 231, DateTimeKind.Local).AddTicks(9671));

            migrationBuilder.AlterColumn<double>(
                name: "MinPrice",
                table: "Promotion",
                type: "float",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<double>(
                name: "Max",
                table: "Promotion",
                type: "float",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 31, 9, 59, 21, 242, DateTimeKind.Local).AddTicks(838),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 31, 9, 8, 36, 233, DateTimeKind.Local).AddTicks(971));

            migrationBuilder.AlterColumn<double>(
                name: "Price",
                table: "OrderDetail",
                type: "float",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.AlterColumn<double>(
                name: "PromotionAmount",
                table: "Order",
                type: "float",
                nullable: true,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)",
                oldNullable: true);

            migrationBuilder.AlterColumn<double>(
                name: "Price",
                table: "Food",
                type: "float",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "29c9f63c-c71b-4564-83dd-95f7aac224cd");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "cde66a72-70b2-4301-ab56-da730f243c4f");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "f40ea4d5-822f-4e2b-b8ca-1ef2cf147fb3", "AQAAAAEAACcQAAAAEG5HuWmEkFhsbBmfGbBRvlvr3p+Zc7b9B0azAZiB8rT7RosdbwmIKmui6uxQARVp2w==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "4e996e9a-cf53-4d30-abd7-ee6fe3977fd1", "AQAAAAEAACcQAAAAEBq1HokeU6T/zNSbluyXjFYPSkrAbV+ffeqo+Maei0Rte2Z8ApE6NymsaRuV3lLJfQ==" });

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 1,
                column: "Price",
                value: 15000.0);

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 2,
                column: "Price",
                value: 10000.0);

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 3,
                column: "Price",
                value: 7000.0);

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 4,
                column: "Price",
                value: 5000.0);

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 31, 9, 59, 21, 276, DateTimeKind.Local).AddTicks(7219));

            migrationBuilder.UpdateData(
                table: "OrderDetail",
                keyColumns: new[] { "FoodID", "OrderID" },
                keyValues: new object[] { 1, 1 },
                column: "Price",
                value: 12000.0);

            migrationBuilder.UpdateData(
                table: "OrderDetail",
                keyColumns: new[] { "FoodID", "OrderID" },
                keyValues: new object[] { 3, 1 },
                column: "Price",
                value: 5000.0);

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "Max", "MinPrice", "StartDate" },
                values: new object[] { 5000.0, 50000.0, new DateTime(2021, 5, 31, 9, 59, 21, 277, DateTimeKind.Local).AddTicks(9448) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 31, 9, 59, 21, 278, DateTimeKind.Local).AddTicks(2182));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 31, 9, 8, 36, 231, DateTimeKind.Local).AddTicks(9671),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 31, 9, 59, 21, 240, DateTimeKind.Local).AddTicks(8275));

            migrationBuilder.AlterColumn<int>(
                name: "MinPrice",
                table: "Promotion",
                type: "int",
                nullable: false,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.AlterColumn<int>(
                name: "Max",
                table: "Promotion",
                type: "int",
                nullable: false,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 31, 9, 8, 36, 233, DateTimeKind.Local).AddTicks(971),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 31, 9, 59, 21, 242, DateTimeKind.Local).AddTicks(838));

            migrationBuilder.AlterColumn<decimal>(
                name: "Price",
                table: "OrderDetail",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.AlterColumn<decimal>(
                name: "PromotionAmount",
                table: "Order",
                type: "decimal(18,2)",
                nullable: true,
                oldClrType: typeof(double),
                oldType: "float",
                oldNullable: true);

            migrationBuilder.AlterColumn<decimal>(
                name: "Price",
                table: "Food",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "1a94b90a-1a7b-4060-8473-a381366e4a2b");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "30199e90-43c5-46db-aa42-8e4ef17605b9");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "35a8589c-6c18-4784-9e9d-ec95037bdf2b", "AQAAAAEAACcQAAAAEA8c0uoSUcsZ1YMGx8fkfhnr0G2w39bZUBFzMrV8zcdXsMkkDIiqN0xPmr7G69du+A==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "312a2b98-a0fb-43be-8d82-4e98d3da27d1", "AQAAAAEAACcQAAAAENaDsGQXKHea3De/5Cqq8qGH0j1XgFpdmo+QTJeeMQbQa6AYg9Uws+i4wapO3Yt+ew==" });

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 1,
                column: "Price",
                value: 15000m);

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 2,
                column: "Price",
                value: 10000m);

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 3,
                column: "Price",
                value: 7000m);

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 4,
                column: "Price",
                value: 5000m);

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 31, 9, 8, 36, 272, DateTimeKind.Local).AddTicks(297));

            migrationBuilder.UpdateData(
                table: "OrderDetail",
                keyColumns: new[] { "FoodID", "OrderID" },
                keyValues: new object[] { 1, 1 },
                column: "Price",
                value: 12000m);

            migrationBuilder.UpdateData(
                table: "OrderDetail",
                keyColumns: new[] { "FoodID", "OrderID" },
                keyValues: new object[] { 3, 1 },
                column: "Price",
                value: 5000m);

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "Max", "MinPrice", "StartDate" },
                values: new object[] { 5000, 50000, new DateTime(2021, 5, 31, 9, 8, 36, 273, DateTimeKind.Local).AddTicks(2434) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 31, 9, 8, 36, 273, DateTimeKind.Local).AddTicks(4879));
        }
    }
}
