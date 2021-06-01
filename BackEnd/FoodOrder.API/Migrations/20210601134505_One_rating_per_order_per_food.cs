using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class One_rating_per_order_per_food : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_Rating",
                table: "Rating");

           
            migrationBuilder.DropColumn(
                name: "ID",
                table: "Rating"
                );

            migrationBuilder.AddColumn<int>(
                name: "OrderID",
                table: "Rating");


            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 20, 45, 3, 716, DateTimeKind.Local).AddTicks(6217),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 18, 15, 9, 498, DateTimeKind.Local).AddTicks(8745));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 20, 45, 3, 717, DateTimeKind.Local).AddTicks(8222),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 18, 15, 9, 500, DateTimeKind.Local).AddTicks(5393));

            migrationBuilder.AddPrimaryKey(
                name: "PK_Rating",
                table: "Rating",
                columns: new[] { "OrderID", "AppUserID", "FoodID" });

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "f90a5ac6-e417-4d93-853a-9342f4396bb5");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "7e632784-4e44-4415-a0d1-04f3e855d5df");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "7b557b2e-26e2-4bcd-92d2-6836b4f7a4d6", "AQAAAAEAACcQAAAAENwnYQovlmDmdOR6pJRot9Ww1VA0VNmxolVRndmqnE5Xb0oLb7+dDS8JhZUhlLob+A==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "4e44e562-eab1-4a64-9b6c-03f2631b4154", "AQAAAAEAACcQAAAAEHvE9jKu/mUho/Urs6QkE4KFRRmz+dYmS4/K7xC4fburKoLM3m4pomZrZZh99cBpdw==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 1, 20, 45, 3, 766, DateTimeKind.Local).AddTicks(4012));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 1, 20, 45, 3, 767, DateTimeKind.Local).AddTicks(5983));

            migrationBuilder.AddForeignKey(
                name: "FK_Rating_Order_OrderID",
                table: "Rating",
                column: "OrderID",
                principalTable: "Order",
                principalColumn: "ID",
                onDelete: ReferentialAction.NoAction,
                onUpdate: ReferentialAction.NoAction);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Rating_Order_OrderID",
                table: "Rating");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Rating",
                table: "Rating");

            migrationBuilder.RenameColumn(
                name: "OrderID",
                table: "Rating",
                newName: "ID");

            migrationBuilder.AlterColumn<int>(
                name: "ID",
                table: "Rating",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .Annotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 18, 15, 9, 498, DateTimeKind.Local).AddTicks(8745),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 20, 45, 3, 716, DateTimeKind.Local).AddTicks(6217));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 18, 15, 9, 500, DateTimeKind.Local).AddTicks(5393),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 20, 45, 3, 717, DateTimeKind.Local).AddTicks(8222));

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
        }
    }
}
