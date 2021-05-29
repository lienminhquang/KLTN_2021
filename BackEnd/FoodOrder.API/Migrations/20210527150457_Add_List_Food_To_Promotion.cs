using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_List_Food_To_Promotion : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 27, 22, 4, 56, 294, DateTimeKind.Local).AddTicks(166),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 542, DateTimeKind.Local).AddTicks(2603));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 27, 22, 4, 56, 294, DateTimeKind.Local).AddTicks(449),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 542, DateTimeKind.Local).AddTicks(3003));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 27, 22, 4, 56, 292, DateTimeKind.Local).AddTicks(8032),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 540, DateTimeKind.Local).AddTicks(3521));

            migrationBuilder.AddColumn<bool>(
                name: "IsGlobal",
                table: "Promotion",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.CreateTable(
                name: "PromotionFood",
                columns: table => new
                {
                    FoodID = table.Column<int>(type: "int", nullable: false),
                    PromotionID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PromotionFood", x => new { x.FoodID, x.PromotionID });
                    table.ForeignKey(
                        name: "FK_PromotionFood_Food_FoodID",
                        column: x => x.FoodID,
                        principalTable: "Food",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PromotionFood_Promotion_PromotionID",
                        column: x => x.PromotionID,
                        principalTable: "Promotion",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "a2a34aa7-c2f3-48a4-9196-e8c97c9cedbe");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "b235833e-d7c7-4f44-8431-d9dc4dd35ec2");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "2f6e4b06-5cc2-40fe-bf88-c5190484c3a9", "AQAAAAEAACcQAAAAELkbjtU/jQRRxG1AgCmJ9b+PdUitHgmPa42zBZUfnmES5Ak9LDZwm4sbopeQtdqguA==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "dc8b0f60-1bfa-4d3f-9063-08a64b2355ed", "AQAAAAEAACcQAAAAEO07sZuhc4VJNLTRf1y4a7N1kevC7GxirnWMl3TVyYZhhnF/k2FVrot6Yfo6uYNxnQ==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 27, 22, 4, 56, 337, DateTimeKind.Local).AddTicks(3431));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 5, 27, 22, 4, 56, 338, DateTimeKind.Local).AddTicks(3352), new DateTime(2021, 5, 27, 22, 4, 56, 338, DateTimeKind.Local).AddTicks(5974) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 27, 22, 4, 56, 338, DateTimeKind.Local).AddTicks(8481));

            migrationBuilder.CreateIndex(
                name: "IX_PromotionFood_PromotionID",
                table: "PromotionFood",
                column: "PromotionID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PromotionFood");

            migrationBuilder.DropColumn(
                name: "IsGlobal",
                table: "Promotion");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 542, DateTimeKind.Local).AddTicks(2603),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 27, 22, 4, 56, 294, DateTimeKind.Local).AddTicks(166));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 542, DateTimeKind.Local).AddTicks(3003),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 27, 22, 4, 56, 294, DateTimeKind.Local).AddTicks(449));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 27, 18, 21, 14, 540, DateTimeKind.Local).AddTicks(3521),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 27, 22, 4, 56, 292, DateTimeKind.Local).AddTicks(8032));

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
    }
}
