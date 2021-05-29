using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Saparate_Promotion_and_SaleCampaign : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PromotionFood");

            migrationBuilder.DropColumn(
                name: "CreatedDate",
                table: "Promotion");

            migrationBuilder.RenameColumn(
                name: "Amount",
                table: "Promotion",
                newName: "UseTimes");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 29, 15, 37, 23, 262, DateTimeKind.Local).AddTicks(7201),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 28, 15, 45, 21, 252, DateTimeKind.Local).AddTicks(9527));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 29, 15, 37, 23, 263, DateTimeKind.Local).AddTicks(8902),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 28, 15, 45, 21, 252, DateTimeKind.Local).AddTicks(9818));

            migrationBuilder.AddColumn<int>(
                name: "SaleCampaignID",
                table: "Order",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "SaleCampaignID",
                table: "Food",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "SaleCampaign",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Desciption = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    StartDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EndDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Percent = table.Column<float>(type: "real", nullable: false),
                    Enabled = table.Column<bool>(type: "bit", nullable: false),
                    Priority = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SaleCampaign", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "SaleCampaignFood",
                columns: table => new
                {
                    FoodID = table.Column<int>(type: "int", nullable: false),
                    SaleCampaignID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SaleCampaignFood", x => new { x.FoodID, x.SaleCampaignID });
                    table.ForeignKey(
                        name: "FK_SaleCampaignFood_Food_FoodID",
                        column: x => x.FoodID,
                        principalTable: "Food",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SaleCampaignFood_SaleCampaign_SaleCampaignID",
                        column: x => x.SaleCampaignID,
                        principalTable: "SaleCampaign",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "71ccdfaa-ea59-45d7-a5dc-e59db5167f74");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "dd79eca4-0825-441b-8539-929fb11309a9");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "1a43fd5c-a063-44a7-8c1d-d8281ef9ab30", "AQAAAAEAACcQAAAAEGEGfnVEBx4HAxWf01nlUf05/0CWZV9MvCqxt3wvgBIE0yNF6Ygr41wkirJXETWGmg==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "3f325bb9-58f6-41c6-aa13-db9808e7c222", "AQAAAAEAACcQAAAAEMV6DBZOI8fBIgE5MXaaQU1K4DxmMtxlHeeNQi30TW5krfu9PQWSBlKhKEjXPgb5YA==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 29, 15, 37, 23, 298, DateTimeKind.Local).AddTicks(726));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 5, 29, 15, 37, 23, 299, DateTimeKind.Local).AddTicks(8352));

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 29, 15, 37, 23, 300, DateTimeKind.Local).AddTicks(2991));

            migrationBuilder.CreateIndex(
                name: "IX_Order_SaleCampaignID",
                table: "Order",
                column: "SaleCampaignID");

            migrationBuilder.CreateIndex(
                name: "IX_Food_SaleCampaignID",
                table: "Food",
                column: "SaleCampaignID");

            migrationBuilder.CreateIndex(
                name: "IX_SaleCampaignFood_SaleCampaignID",
                table: "SaleCampaignFood",
                column: "SaleCampaignID");

            migrationBuilder.AddForeignKey(
                name: "FK_Food_SaleCampaign_SaleCampaignID",
                table: "Food",
                column: "SaleCampaignID",
                principalTable: "SaleCampaign",
                principalColumn: "ID",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Order_SaleCampaign_SaleCampaignID",
                table: "Order",
                column: "SaleCampaignID",
                principalTable: "SaleCampaign",
                principalColumn: "ID",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Food_SaleCampaign_SaleCampaignID",
                table: "Food");

            migrationBuilder.DropForeignKey(
                name: "FK_Order_SaleCampaign_SaleCampaignID",
                table: "Order");

            migrationBuilder.DropTable(
                name: "SaleCampaignFood");

            migrationBuilder.DropTable(
                name: "SaleCampaign");

            migrationBuilder.DropIndex(
                name: "IX_Order_SaleCampaignID",
                table: "Order");

            migrationBuilder.DropIndex(
                name: "IX_Food_SaleCampaignID",
                table: "Food");

            migrationBuilder.DropColumn(
                name: "SaleCampaignID",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "SaleCampaignID",
                table: "Food");

            migrationBuilder.RenameColumn(
                name: "UseTimes",
                table: "Promotion",
                newName: "Amount");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 28, 15, 45, 21, 252, DateTimeKind.Local).AddTicks(9527),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 29, 15, 37, 23, 262, DateTimeKind.Local).AddTicks(7201));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 28, 15, 45, 21, 252, DateTimeKind.Local).AddTicks(9818),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 29, 15, 37, 23, 263, DateTimeKind.Local).AddTicks(8902));

            migrationBuilder.AddColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 28, 15, 45, 21, 251, DateTimeKind.Local).AddTicks(7622));

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
                value: "e7b43d88-f9ea-4bef-8e64-238682c0b2fc");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "54a6835f-bc2a-4ca0-9e45-8ed528846a9d");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "604b6133-2b8d-4af0-be4d-9bd4441daebe", "AQAAAAEAACcQAAAAEHuj1/PO/IlTn2QydTHqqT667je8/A2+Xn9+QS4gMZr4kWuRKhmI+ef9RLzWb1/QEQ==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "53edd8d3-4327-4af7-bf80-c5790a80a122", "AQAAAAEAACcQAAAAEEYx+cO1nxhYR/A4/gSFTiZ3hzPiBcSyXG33Hth5mAMQ4ymENLXylwsg9r9Wb2ZN3Q==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 28, 15, 45, 21, 303, DateTimeKind.Local).AddTicks(8937));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "CreatedDate", "StartDate" },
                values: new object[] { new DateTime(2021, 5, 28, 15, 45, 21, 305, DateTimeKind.Local).AddTicks(2392), new DateTime(2021, 5, 28, 15, 45, 21, 305, DateTimeKind.Local).AddTicks(5859) });

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 28, 15, 45, 21, 305, DateTimeKind.Local).AddTicks(9417));

            migrationBuilder.CreateIndex(
                name: "IX_PromotionFood_PromotionID",
                table: "PromotionFood",
                column: "PromotionID");
        }
    }
}
