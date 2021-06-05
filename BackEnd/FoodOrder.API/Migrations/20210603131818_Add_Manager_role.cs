using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_Manager_role : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 3, 20, 18, 17, 50, DateTimeKind.Local).AddTicks(8280),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 23, 50, 4, 595, DateTimeKind.Local).AddTicks(7859));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 3, 20, 18, 17, 52, DateTimeKind.Local).AddTicks(754),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 23, 50, 4, 597, DateTimeKind.Local).AddTicks(4210));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                columns: new[] { "ConcurrencyStamp", "NormalizedName" },
                values: new object[] { "490c9750-ec77-4a76-824b-e8f5ffe236fd", "USER" });

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "2a96c8f2-aef8-4129-80ce-f945a87347c4");

            migrationBuilder.InsertData(
                table: "AppRole",
                columns: new[] { "Id", "ConcurrencyStamp", "Description", "Name", "NormalizedName" },
                values: new object[] { new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"), "76e5598b-30a5-4368-979c-b905e6ee261d", "This is Manager role.", "manager", "MANAGER" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "73252593-d625-4e8d-b7dc-538a4e3d5eab", "AQAAAAEAACcQAAAAEHeXlawf/Gn0kfRXxgSqv06AVf+bdcYQE9es3bsQymi8rEnwCGodDMiA/jlIE3Yrhw==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "e499bfe0-7960-485c-91f1-5393e8ecf62f", "AQAAAAEAACcQAAAAEPCVh7ZwZAt+UqpON4U/cwIj0kfvF74tSgUt5B0EeA65L07MTuZ0lvo/S/D6ExTOEQ==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 3, 20, 18, 17, 95, DateTimeKind.Local).AddTicks(4483));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 3, 20, 18, 17, 96, DateTimeKind.Local).AddTicks(6771));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"));

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 23, 50, 4, 595, DateTimeKind.Local).AddTicks(7859),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 3, 20, 18, 17, 50, DateTimeKind.Local).AddTicks(8280));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 23, 50, 4, 597, DateTimeKind.Local).AddTicks(4210),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 3, 20, 18, 17, 52, DateTimeKind.Local).AddTicks(754));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                columns: new[] { "ConcurrencyStamp", "NormalizedName" },
                values: new object[] { "f5e78c26-fdde-4435-bbba-a9710341995e", "User" });

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
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 1, 23, 50, 4, 656, DateTimeKind.Local).AddTicks(5960));
        }
    }
}
