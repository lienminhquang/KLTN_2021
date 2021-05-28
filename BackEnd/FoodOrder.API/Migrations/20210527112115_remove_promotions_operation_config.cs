using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class remove_promotions_operation_config : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 542, DateTimeKind.Local).AddTicks(2603),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 870, DateTimeKind.Local).AddTicks(2815));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 542, DateTimeKind.Local).AddTicks(3003),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 870, DateTimeKind.Local).AddTicks(3110));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 540, DateTimeKind.Local).AddTicks(3521),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 869, DateTimeKind.Local).AddTicks(585));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "ba474cda-4293-4ea5-8a7d-b969d14a5982");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "0a6470a4-64c7-4e3a-813b-2fbc1fec9ccf");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "36fa296e-740f-4a51-86ae-e1ae7a7eeae0", "AQAAAAEAACcQAAAAEDfd+6CtFL3YZO+UCzY29Db9EZ42Sp27034Q+xz7t4nSSyCaVic/RvnENoRBTfMOlg==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "ac136d9b-7a47-4c7f-b7c3-8423f7e06acb", "AQAAAAEAACcQAAAAEC8AH/2uR6DhGN+6rnDJ6WHOOVev/avbra1XkZbeUOt0HIv45MtPHZ/3of2TUf8cWw==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 27, 18, 21, 14, 590, DateTimeKind.Local).AddTicks(7742));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 5, 27, 18, 21, 14, 592, DateTimeKind.Local).AddTicks(6987), new DateTime(2021, 5, 27, 18, 21, 14, 593, DateTimeKind.Local).AddTicks(472) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 27, 18, 21, 14, 593, DateTimeKind.Local).AddTicks(3895));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 870, DateTimeKind.Local).AddTicks(2815),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 542, DateTimeKind.Local).AddTicks(2603));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 870, DateTimeKind.Local).AddTicks(3110),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 542, DateTimeKind.Local).AddTicks(3003));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 22, 21, 55, 33, 869, DateTimeKind.Local).AddTicks(585),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 540, DateTimeKind.Local).AddTicks(3521));

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
        }
    }
}
