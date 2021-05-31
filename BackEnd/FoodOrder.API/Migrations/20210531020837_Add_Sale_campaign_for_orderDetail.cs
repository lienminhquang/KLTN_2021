using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Add_Sale_campaign_for_orderDetail : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 31, 9, 8, 36, 231, DateTimeKind.Local).AddTicks(9671),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 29, 15, 37, 23, 262, DateTimeKind.Local).AddTicks(7201));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 31, 9, 8, 36, 233, DateTimeKind.Local).AddTicks(971),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 29, 15, 37, 23, 263, DateTimeKind.Local).AddTicks(8902));

            migrationBuilder.AddColumn<int>(
                name: "SaleCampaignID",
                table: "OrderDetail",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<float>(
                name: "SalePercent",
                table: "OrderDetail",
                type: "real",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "1a94b90a-1a7b-4060-8473-a381366e4a2b");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "30199e90-43c5-46db-aa42-8e4ef17605b9");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "35a8589c-6c18-4784-9e9d-ec95037bdf2b", "AQAAAAEAACcQAAAAEA8c0uoSUcsZ1YMGx8fkfhnr0G2w39bZUBFzMrV8zcdXsMkkDIiqN0xPmr7G69du+A==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "312a2b98-a0fb-43be-8d82-4e98d3da27d1", "AQAAAAEAACcQAAAAENaDsGQXKHea3De/5Cqq8qGH0j1XgFpdmo+QTJeeMQbQa6AYg9Uws+i4wapO3Yt+ew==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 5, 31, 9, 8, 36, 272, DateTimeKind.Local).AddTicks(297));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 5, 31, 9, 8, 36, 273, DateTimeKind.Local).AddTicks(2434));

            migrationBuilder.UpdateData(
                table: "Rating",
                keyColumns: new[] { "AppUserID", "FoodID" },
                keyValues: new object[] { new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"), 1 },
                column: "LastCreatedTime",
                value: new DateTime(2021, 5, 31, 9, 8, 36, 273, DateTimeKind.Local).AddTicks(4879));

            migrationBuilder.CreateIndex(
                name: "IX_OrderDetail_SaleCampaignID",
                table: "OrderDetail",
                column: "SaleCampaignID");

            migrationBuilder.AddForeignKey(
                name: "FK_OrderDetail_SaleCampaign_SaleCampaignID",
                table: "OrderDetail",
                column: "SaleCampaignID",
                principalTable: "SaleCampaign",
                principalColumn: "ID",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_OrderDetail_SaleCampaign_SaleCampaignID",
                table: "OrderDetail");

            migrationBuilder.DropIndex(
                name: "IX_OrderDetail_SaleCampaignID",
                table: "OrderDetail");

            migrationBuilder.DropColumn(
                name: "SaleCampaignID",
                table: "OrderDetail");

            migrationBuilder.DropColumn(
                name: "SalePercent",
                table: "OrderDetail");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 29, 15, 37, 23, 262, DateTimeKind.Local).AddTicks(7201),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 31, 9, 8, 36, 231, DateTimeKind.Local).AddTicks(9671));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 5, 29, 15, 37, 23, 263, DateTimeKind.Local).AddTicks(8902),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 5, 31, 9, 8, 36, 233, DateTimeKind.Local).AddTicks(971));

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
        }
    }
}
