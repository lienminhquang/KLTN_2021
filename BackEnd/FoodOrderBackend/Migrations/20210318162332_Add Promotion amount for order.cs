using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrderBackend.Migrations
{
    public partial class AddPromotionamountfororder : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 691, DateTimeKind.Local).AddTicks(4246),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 90, DateTimeKind.Local).AddTicks(1913));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 691, DateTimeKind.Local).AddTicks(4694),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 90, DateTimeKind.Local).AddTicks(2539));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 689, DateTimeKind.Local).AddTicks(8655),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 88, DateTimeKind.Local).AddTicks(7532));

            migrationBuilder.AddColumn<decimal>(
                name: "PromotionAmount",
                table: "Order",
                type: "decimal(18,2)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "9ad0bb0b-0a99-401a-81c9-23f4ef5ef2b5");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "6b15a5eb-ad51-4d85-87c0-41b27a1615b0");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "fc7e0537-717e-47bf-b82b-ae1d8e07508f", "AQAAAAEAACcQAAAAEIgkDxtaZplnDwTgeGNjeEw91zlBQpr8oRytX3P0yWm22CAKin58H9wCzr+oKeKolg==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "c7695217-bc3e-4c7b-97d7-b5f0e55cc24c", "AQAAAAEAACcQAAAAEPDnKFoV4LOAOOnjAlYWPGzYELh7nHoKLn0h8U7lhJexD7wVz7l59ysMhJE91GvDXg==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 3, 18, 23, 23, 31, 739, DateTimeKind.Local).AddTicks(9133));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 3, 18, 23, 23, 31, 740, DateTimeKind.Local).AddTicks(9248), new DateTime(2021, 3, 18, 23, 23, 31, 741, DateTimeKind.Local).AddTicks(2138) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 3, 18, 23, 23, 31, 741, DateTimeKind.Local).AddTicks(4911));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PromotionAmount",
                table: "Order");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 90, DateTimeKind.Local).AddTicks(1913),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 691, DateTimeKind.Local).AddTicks(4246));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 90, DateTimeKind.Local).AddTicks(2539),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 691, DateTimeKind.Local).AddTicks(4694));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 13, 23, 88, DateTimeKind.Local).AddTicks(7532),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 689, DateTimeKind.Local).AddTicks(8655));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "16349281-f43a-4b61-9117-a507b9b3d13f");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "64241348-79de-4b51-8da8-7da1a5c36308");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "5b9c6899-30bd-4866-aeca-41f7091aa8e9", "AQAAAAEAACcQAAAAEDV6OCinywMuR0BpXBQ2qCut24U8PrDJXajXWHnG/KLQeexWK2jSrMVXGHKSUucKUg==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "359cb04b-be2b-4b52-bcba-d200648206c9", "AQAAAAEAACcQAAAAEIyZFJ5btZRqQSTNr/H/ez4KjuwH1x/4Jct7G5KYFxw8AszbQerk/AM1A0ROc1UWZw==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 3, 18, 23, 13, 23, 191, DateTimeKind.Local).AddTicks(9527));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 3, 18, 23, 13, 23, 192, DateTimeKind.Local).AddTicks(9080), new DateTime(2021, 3, 18, 23, 13, 23, 193, DateTimeKind.Local).AddTicks(1832) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 3, 18, 23, 13, 23, 193, DateTimeKind.Local).AddTicks(4451));
        }
    }
}
