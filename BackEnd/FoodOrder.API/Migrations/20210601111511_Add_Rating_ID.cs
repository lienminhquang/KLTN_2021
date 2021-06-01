using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_Rating_ID : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_Rating",
                table: "Rating");

            migrationBuilder.DeleteData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 });

            migrationBuilder.DropColumn(
                name: "LastCreatedTime",
                table: "Rating");

            migrationBuilder.AddColumn<int>(
                name: "ID",
                table: "Rating",
                type: "int",
                nullable: false,
                defaultValue: 0)
                .Annotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeCreate",
                table: "Rating",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 18, 15, 9, 498, DateTimeKind.Local).AddTicks(8745),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 31, 9, 59, 21, 240, DateTimeKind.Local).AddTicks(8275));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 18, 15, 9, 500, DateTimeKind.Local).AddTicks(5393),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 31, 9, 59, 21, 242, DateTimeKind.Local).AddTicks(838));

            migrationBuilder.AddPrimaryKey(
                name: "PK_Rating",
                table: "Rating",
                column: "ID");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "1619a3c7-2e62-4579-bfb6-db4ccabb2df4");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "178858ea-0e37-4229-91d8-571d1de456cb");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "1f6c7c63-9b0f-4cf5-8ac8-a8ab5c0353b3", "AQAAAAEAACcQAAAAEPZbKi2uGob5xBEE0DDWmR5VyHBvQo3WVSm8odqJTR8NvOuJYdcskKUFTp5PtOzewQ==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "2397ea97-63be-42a4-8d4b-c1436c785569", "AQAAAAEAACcQAAAAEDVnW+iehx4fN7g10FKTmFhh7JV8Nmcq5nE71PThmARPFZrxk9yiCDI9UxfqLPuPPQ==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 1, 18, 15, 9, 559, DateTimeKind.Local).AddTicks(9494));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 1, 18, 15, 9, 561, DateTimeKind.Local).AddTicks(6050));

            migrationBuilder.InsertData(
                table: "Rating",
                columns: new[] { "ID", "AppUserID", "Comment", "FoodID", "Star", "TimeCreate" },
                values: new object[] { 1, new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), "Good", 1, 5, new DateTime(2021, 6, 1, 18, 15, 9, 562, DateTimeKind.Local).AddTicks(118) });

            migrationBuilder.CreateIndex(
                name: "IX_Rating_AppUserID",
                table: "Rating",
                column: "AppUserID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_Rating",
                table: "Rating");

            migrationBuilder.DropIndex(
                name: "IX_Rating_AppUserID",
                table: "Rating");

            migrationBuilder.DropColumn(
                name: "ID",
                table: "Rating");

            migrationBuilder.DropColumn(
                name: "TimeCreate",
                table: "Rating");

            migrationBuilder.AddColumn<DateTime>(
                name: "LastCreatedTime",
                table: "Rating",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 31, 9, 59, 21, 240, DateTimeKind.Local).AddTicks(8275),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 18, 15, 9, 498, DateTimeKind.Local).AddTicks(8745));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 31, 9, 59, 21, 242, DateTimeKind.Local).AddTicks(838),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 18, 15, 9, 500, DateTimeKind.Local).AddTicks(5393));

            migrationBuilder.AddPrimaryKey(
                name: "PK_Rating",
                table: "Rating",
                columns: new[] { "AppUserID", "FoodID" });

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
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 31, 9, 59, 21, 276, DateTimeKind.Local).AddTicks(7219));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 5, 31, 9, 59, 21, 277, DateTimeKind.Local).AddTicks(9448));

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 31, 9, 59, 21, 278, DateTimeKind.Local).AddTicks(2182));
        }
    }
}
