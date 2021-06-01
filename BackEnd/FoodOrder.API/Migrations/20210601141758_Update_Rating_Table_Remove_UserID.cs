using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Update_Rating_Table_Remove_UserID : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Rating_AppUser_AppUserID",
                table: "Rating");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Rating",
                table: "Rating");

            migrationBuilder.RenameColumn(
                name: "AppUserID",
                table: "Rating",
                newName: "AppUserId");

            migrationBuilder.RenameIndex(
                name: "IX_Rating_AppUserID",
                table: "Rating",
                newName: "IX_Rating_AppUserId");

            migrationBuilder.AlterColumn<Guid>(
                name: "AppUserId",
                table: "Rating",
                type: "uniqueidentifier",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 21, 17, 56, 744, DateTimeKind.Local).AddTicks(8549),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 20, 45, 3, 716, DateTimeKind.Local).AddTicks(6217));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 21, 17, 56, 746, DateTimeKind.Local).AddTicks(6478),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 20, 45, 3, 717, DateTimeKind.Local).AddTicks(8222));

            migrationBuilder.AddPrimaryKey(
                name: "PK_Rating",
                table: "Rating",
                columns: new[] { "OrderID", "FoodID" });

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
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 1, 21, 17, 56, 798, DateTimeKind.Local).AddTicks(8614));

            migrationBuilder.AddForeignKey(
                name: "FK_Rating_AppUser_AppUserId",
                table: "Rating",
                column: "AppUserId",
                principalTable: "AppUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Rating_AppUser_AppUserId",
                table: "Rating");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Rating",
                table: "Rating");

            migrationBuilder.RenameColumn(
                name: "AppUserId",
                table: "Rating",
                newName: "AppUserID");

            migrationBuilder.RenameIndex(
                name: "IX_Rating_AppUserId",
                table: "Rating",
                newName: "IX_Rating_AppUserID");

            migrationBuilder.AlterColumn<Guid>(
                name: "AppUserID",
                table: "Rating",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 20, 45, 3, 716, DateTimeKind.Local).AddTicks(6217),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 21, 17, 56, 744, DateTimeKind.Local).AddTicks(8549));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 1, 20, 45, 3, 717, DateTimeKind.Local).AddTicks(8222),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 1, 21, 17, 56, 746, DateTimeKind.Local).AddTicks(6478));

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
                name: "FK_Rating_AppUser_AppUserID",
                table: "Rating",
                column: "AppUserID",
                principalTable: "AppUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
