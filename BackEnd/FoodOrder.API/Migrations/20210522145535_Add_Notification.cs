using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_Notification : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 870, DateTimeKind.Local).AddTicks(2815),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 773, DateTimeKind.Local).AddTicks(9980));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 870, DateTimeKind.Local).AddTicks(3110),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 774, DateTimeKind.Local).AddTicks(377));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 869, DateTimeKind.Local).AddTicks(585),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 772, DateTimeKind.Local).AddTicks(5032));

            migrationBuilder.CreateTable(
                name: "Notification",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Message = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    TimeCreated = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Type = table.Column<int>(type: "int", nullable: false),
                    UserReceived = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Notification", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Notification_AppUser_UserID",
                        column: x => x.UserID,
                        principalTable: "AppUser",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "34784487-640f-4d87-ad51-b66505dddedd");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "e0246349-b427-4089-a93b-f55fe690354f");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "e95345fb-15d5-47cd-8f05-b67ae4fc3908", "AQAAAAEAACcQAAAAEFbUilFRGbmUc0hpmRY/xmww9ZqxRhuAfraFPrnbEOkNfnh+ibg+5U+p6VkQFJ8GKA==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "c022030e-880e-4cee-aa65-e7d165b0eb33", "AQAAAAEAACcQAAAAEEl0b4F5ZET6A8KUOBuOkz0s5IgwPK6tqete26pLH4GuLHL+XknVoyuttpsAGeWUzw==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 22, 21, 55, 33, 903, DateTimeKind.Local).AddTicks(9457));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 5, 22, 21, 55, 33, 904, DateTimeKind.Local).AddTicks(9077), new DateTime(2021, 5, 22, 21, 55, 33, 905, DateTimeKind.Local).AddTicks(1671) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 22, 21, 55, 33, 905, DateTimeKind.Local).AddTicks(4447));

            migrationBuilder.CreateIndex(
                name: "IX_Notification_UserID",
                table: "Notification",
                column: "UserID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Notification");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 773, DateTimeKind.Local).AddTicks(9980),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 870, DateTimeKind.Local).AddTicks(2815));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 774, DateTimeKind.Local).AddTicks(377),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 870, DateTimeKind.Local).AddTicks(3110));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 21, 21, 50, 43, 772, DateTimeKind.Local).AddTicks(5032),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 869, DateTimeKind.Local).AddTicks(585));

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
                column: "CreatedDate",
                value: new DateTime(2021, 5, 21, 21, 50, 43, 810, DateTimeKind.Local).AddTicks(9936));

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
    }
}
