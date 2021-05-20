using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_address_table : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 438, DateTimeKind.Local).AddTicks(315),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 0, 50, 20, 543, DateTimeKind.Local).AddTicks(458));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 438, DateTimeKind.Local).AddTicks(579),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 0, 50, 20, 543, DateTimeKind.Local).AddTicks(720));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 436, DateTimeKind.Local).AddTicks(9152),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 0, 50, 20, 541, DateTimeKind.Local).AddTicks(9287));

            migrationBuilder.CreateTable(
                name: "Address",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AppUserID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AddressString = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Address", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Address_AppUser_AppUserID",
                        column: x => x.AppUserID,
                        principalTable: "AppUser",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

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

            migrationBuilder.CreateIndex(
                name: "IX_Address_AppUserID",
                table: "Address",
                column: "AppUserID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Address");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 0, 50, 20, 543, DateTimeKind.Local).AddTicks(458),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 438, DateTimeKind.Local).AddTicks(315));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 0, 50, 20, 543, DateTimeKind.Local).AddTicks(720),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 438, DateTimeKind.Local).AddTicks(579));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 20, 0, 50, 20, 541, DateTimeKind.Local).AddTicks(9287),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 20, 23, 5, 15, 436, DateTimeKind.Local).AddTicks(9152));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "a69aead7-1cb5-4e8a-9156-bdaa71c28507");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "8337a106-98c8-4df0-a902-dbb2c3ad6350");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "e030f457-047e-4d4d-aef6-a8897fb61baa", "AQAAAAEAACcQAAAAEDBiXi9PaUn0rsglv/+v4F1yPx1Glt/4JMLg6eHPCTKXjxEATX8E9myNP44lIdgX0w==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "6d4ec07d-a548-4eb2-8049-ff62e1711d87", "AQAAAAEAACcQAAAAEKfJC/d7ajohEek80PaKcxFYDr/PIDeJYILudxcodpaCFtztHMfaFNyp+tGwqFDXTA==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 20, 0, 50, 20, 591, DateTimeKind.Local).AddTicks(2644));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 5, 20, 0, 50, 20, 592, DateTimeKind.Local).AddTicks(1573), new DateTime(2021, 5, 20, 0, 50, 20, 592, DateTimeKind.Local).AddTicks(4137) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 20, 0, 50, 20, 592, DateTimeKind.Local).AddTicks(6695));
        }
    }
}
