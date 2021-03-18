using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrderBackend.Migrations
{
    public partial class AddImageTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ImagePath",
                table: "Food");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 994, DateTimeKind.Local).AddTicks(3609),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 691, DateTimeKind.Local).AddTicks(4246));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 994, DateTimeKind.Local).AddTicks(4039),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 691, DateTimeKind.Local).AddTicks(4694));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 993, DateTimeKind.Local).AddTicks(399),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 689, DateTimeKind.Local).AddTicks(8655));

            migrationBuilder.CreateTable(
                name: "Image",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FoodID = table.Column<int>(type: "int", nullable: false),
                    ImagePath = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Caption = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    SortOrder = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Image", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Image_Food_FoodID",
                        column: x => x.FoodID,
                        principalTable: "Food",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "cea8afc0-e182-42db-b32b-9dc4a52258d8");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "705fc5e9-65f4-4867-83d3-1d066d168b4b");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "70b0a433-7adf-4ac8-95a8-fbd2a9ebc294", "AQAAAAEAACcQAAAAECoDCxMrEAtZr36UPVhDAyXqL3aDHZXl7uohb0KonCilWBZzxa2bgspMGl1vqo9mdQ==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "38e54556-ed53-444b-b745-c373f7f27bff", "AQAAAAEAACcQAAAAEKIxvbAjRvfEieJoDq63czHrlS5FnmfoMkrYTmAbrunaC+TfqS1oHSpi1SVqm60GWw==" });

            migrationBuilder.InsertData(
                table: "Image",
                columns: new[] { "ID", "Caption", "FoodID", "ImagePath", "SortOrder" },
                values: new object[,]
                {
                    { 1, "", 1, "default.png", 1 },
                    { 2, "", 2, "default.png", 1 },
                    { 3, "", 3, "default.png", 1 },
                    { 4, "", 4, "default.png", 1 }
                });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 3, 18, 23, 55, 57, 56, DateTimeKind.Local).AddTicks(1466));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 3, 18, 23, 55, 57, 57, DateTimeKind.Local).AddTicks(3767), new DateTime(2021, 3, 18, 23, 55, 57, 57, DateTimeKind.Local).AddTicks(7357) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 3, 18, 23, 55, 57, 58, DateTimeKind.Local).AddTicks(1060));

            migrationBuilder.CreateIndex(
                name: "IX_Image_FoodID",
                table: "Image",
                column: "FoodID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Image");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 691, DateTimeKind.Local).AddTicks(4246),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 994, DateTimeKind.Local).AddTicks(3609));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 691, DateTimeKind.Local).AddTicks(4694),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 994, DateTimeKind.Local).AddTicks(4039));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 18, 23, 23, 31, 689, DateTimeKind.Local).AddTicks(8655),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 18, 23, 55, 56, 993, DateTimeKind.Local).AddTicks(399));

            migrationBuilder.AddColumn<string>(
                name: "ImagePath",
                table: "Food",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

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
                table: "Food",
                keyColumn: "ID",
                keyValue: 1,
                column: "ImagePath",
                value: "default");

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 2,
                column: "ImagePath",
                value: "default");

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 3,
                column: "ImagePath",
                value: "default");

            migrationBuilder.UpdateData(
                table: "Food",
                keyColumn: "ID",
                keyValue: 4,
                column: "ImagePath",
                value: "default");

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
    }
}
