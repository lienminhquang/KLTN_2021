using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Update_Order_Status : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 23, 50, 4, 595, DateTimeKind.Local).AddTicks(7859),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 21, 17, 56, 744, DateTimeKind.Local).AddTicks(8549));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 23, 50, 4, 597, DateTimeKind.Local).AddTicks(4210),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 21, 17, 56, 746, DateTimeKind.Local).AddTicks(6478));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "f5e78c26-fdde-4435-bbba-a9710341995e");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "858c07cc-86c4-47b9-a41a-09c54108ffd4");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "f50932e0-c399-46c0-870b-6bfa57c03f39", "AQAAAAEAACcQAAAAELp7zshb+bBrPu2xXBvYxTt0A29Tx0lo89DsDfo42J03sjqXVKdKAyfZfCimOIlzEw==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "16221181-0f78-48c8-8b1b-2da19e93a716", "AQAAAAEAACcQAAAAEAtmMqFLfyYWlGPKweUZxXc1UllXnemzoVWTPBp+KIIV4regNlsoOPx8MnVP0L0mAg==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 1, 23, 50, 4, 654, DateTimeKind.Local).AddTicks(7116));

            migrationBuilder.UpdateData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 2,
                column: "Name",
                value: "Đang chuẩn bị");

            migrationBuilder.UpdateData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 3,
                column: "Name",
                value: "Đang giao hàng");

            migrationBuilder.UpdateData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 4,
                column: "Name",
                value: "Đã nhận hàng");

            migrationBuilder.UpdateData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 5,
                column: "Name",
                value: "Đã hủy");

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 1, 23, 50, 4, 656, DateTimeKind.Local).AddTicks(5960));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 21, 17, 56, 744, DateTimeKind.Local).AddTicks(8549),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 23, 50, 4, 595, DateTimeKind.Local).AddTicks(7859));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 21, 17, 56, 746, DateTimeKind.Local).AddTicks(6478),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 23, 50, 4, 597, DateTimeKind.Local).AddTicks(4210));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "dab9f3c9-4e6a-4aa8-89ca-85553a0334b8");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "b04bbd82-5274-4128-adc7-ee3d72348d70");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "a3c3d9d7-b00b-43b8-a768-32bd29ec9c78", "AQAAAAEAACcQAAAAELOVywzbAz9w63WNJ3D6YycsT4yqtLs85yz1ps1cHDmAN7Ln3WT7myOaQhn6VJXY0Q==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "32e846d5-0580-4b46-a7bb-37b57ad0430b", "AQAAAAEAACcQAAAAENtNsK0bjsXdJ/SnM9TwfHQIUasUY/sHSqq1Ek45GHXpnCc2/VanEzPm/z37Puk20A==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 1, 21, 17, 56, 797, DateTimeKind.Local).AddTicks(1839));

            migrationBuilder.UpdateData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 2,
                column: "Name",
                value: "Dang chuan bi");

            migrationBuilder.UpdateData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 3,
                column: "Name",
                value: "Dang giao hang");

            migrationBuilder.UpdateData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 4,
                column: "Name",
                value: "Da nhan hang");

            migrationBuilder.UpdateData(
                table: "OrderStatus",
                keyColumn: "ID",
                keyValue: 5,
                column: "Name",
                value: "Da huy");

            migrationBuilder.InsertData(
                table: "OrderStatus",
                columns: new[] { "ID", "Description", "Name" },
                values: new object[] { 1, "", "Dang tiep nhan" });

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 1, 21, 17, 56, 798, DateTimeKind.Local).AddTicks(8614));
        }
    }
}
