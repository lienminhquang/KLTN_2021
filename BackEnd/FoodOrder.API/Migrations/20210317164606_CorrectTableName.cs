using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class CorrectTableName : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AppRoleClaim_AspNetRoles_RoleId",
                table: "AppRoleClaim");

            migrationBuilder.DropForeignKey(
                name: "FK_AppUserClaim_AspNetUsers_UserId",
                table: "AppUserClaim");

            migrationBuilder.DropForeignKey(
                name: "FK_AppUserLogin_AspNetUsers_UserId",
                table: "AppUserLogin");

            migrationBuilder.DropForeignKey(
                name: "FK_AppUserRole_AspNetRoles_RoleId",
                table: "AppUserRole");

            migrationBuilder.DropForeignKey(
                name: "FK_AppUserRole_AspNetUsers_UserId",
                table: "AppUserRole");

            migrationBuilder.DropForeignKey(
                name: "FK_AppUserToken_AspNetUsers_UserId",
                table: "AppUserToken");

            migrationBuilder.DropForeignKey(
                name: "FK_Carts_AspNetUsers_AppUserId",
                table: "Carts");

            migrationBuilder.DropForeignKey(
                name: "FK_Carts_Foods_FoodID",
                table: "Carts");

            migrationBuilder.DropForeignKey(
                name: "FK_FoodCategories_Categories_CategoryID",
                table: "FoodCategories");

            migrationBuilder.DropForeignKey(
                name: "FK_FoodCategories_Foods_FoodID",
                table: "FoodCategories");

            migrationBuilder.DropForeignKey(
                name: "FK_OrderDetails_Foods_FoodID",
                table: "OrderDetails");

            migrationBuilder.DropForeignKey(
                name: "FK_OrderDetails_Orders_OrderID",
                table: "OrderDetails");

            migrationBuilder.DropForeignKey(
                name: "FK_Orders_AspNetUsers_AppUserID",
                table: "Orders");

            migrationBuilder.DropForeignKey(
                name: "FK_Orders_OrderStatuses_OrderStatusID",
                table: "Orders");

            migrationBuilder.DropForeignKey(
                name: "FK_Orders_Promotions_PromotionID",
                table: "Orders");

            migrationBuilder.DropForeignKey(
                name: "FK_Ra_AspNetUsers_AppUserID",
                table: "Ra");

            migrationBuilder.DropForeignKey(
                name: "FK_Ra_Foods_FoodID",
                table: "Ra");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Ra",
                table: "Ra");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Promotions",
                table: "Promotions");

            migrationBuilder.DropPrimaryKey(
                name: "PK_OrderStatuses",
                table: "OrderStatuses");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Orders",
                table: "Orders");

            migrationBuilder.DropPrimaryKey(
                name: "PK_OrderDetails",
                table: "OrderDetails");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Foods",
                table: "Foods");

            migrationBuilder.DropPrimaryKey(
                name: "PK_FoodCategories",
                table: "FoodCategories");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Categories",
                table: "Categories");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Carts",
                table: "Carts");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AspNetUsers",
                table: "AspNetUsers");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AspNetRoles",
                table: "AspNetRoles");

            migrationBuilder.RenameTable(
                name: "Ra",
                newName: "Rating");

            migrationBuilder.RenameTable(
                name: "Promotions",
                newName: "Promotion");

            migrationBuilder.RenameTable(
                name: "OrderStatuses",
                newName: "OrderStatus");

            migrationBuilder.RenameTable(
                name: "Orders",
                newName: "Order");

            migrationBuilder.RenameTable(
                name: "OrderDetails",
                newName: "OrderDetail");

            migrationBuilder.RenameTable(
                name: "Foods",
                newName: "Food");

            migrationBuilder.RenameTable(
                name: "FoodCategories",
                newName: "FoodCategory");

            migrationBuilder.RenameTable(
                name: "Categories",
                newName: "Category");

            migrationBuilder.RenameTable(
                name: "Carts",
                newName: "Cart");

            migrationBuilder.RenameTable(
                name: "AspNetUsers",
                newName: "AppUser");

            migrationBuilder.RenameTable(
                name: "AspNetRoles",
                newName: "AppRole");

            migrationBuilder.RenameIndex(
                name: "IX_Ra_FoodID",
                table: "Rating",
                newName: "IX_Rating_FoodID");

            migrationBuilder.RenameIndex(
                name: "IX_Orders_PromotionID",
                table: "Order",
                newName: "IX_Order_PromotionID");

            migrationBuilder.RenameIndex(
                name: "IX_Orders_OrderStatusID",
                table: "Order",
                newName: "IX_Order_OrderStatusID");

            migrationBuilder.RenameIndex(
                name: "IX_Orders_AppUserID",
                table: "Order",
                newName: "IX_Order_AppUserID");

            migrationBuilder.RenameIndex(
                name: "IX_OrderDetails_FoodID",
                table: "OrderDetail",
                newName: "IX_OrderDetail_FoodID");

            migrationBuilder.RenameIndex(
                name: "IX_FoodCategories_CategoryID",
                table: "FoodCategory",
                newName: "IX_FoodCategory_CategoryID");

            migrationBuilder.RenameIndex(
                name: "IX_Carts_AppUserId",
                table: "Cart",
                newName: "IX_Cart_AppUserId");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 675, DateTimeKind.Local).AddTicks(1031),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 17, 23, 25, 35, 20, DateTimeKind.Local).AddTicks(1020));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 675, DateTimeKind.Local).AddTicks(1533),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 17, 23, 25, 35, 20, DateTimeKind.Local).AddTicks(1556));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 673, DateTimeKind.Local).AddTicks(6249),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 17, 23, 25, 35, 18, DateTimeKind.Local).AddTicks(375));

            migrationBuilder.AddPrimaryKey(
                name: "PK_Rating",
                table: "Rating",
                columns: new[] { "AppUserID", "FoodID" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Promotion",
                table: "Promotion",
                column: "ID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_OrderStatus",
                table: "OrderStatus",
                column: "ID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Order",
                table: "Order",
                column: "ID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_OrderDetail",
                table: "OrderDetail",
                columns: new[] { "OrderID", "FoodID" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Food",
                table: "Food",
                column: "ID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_FoodCategory",
                table: "FoodCategory",
                columns: new[] { "FoodID", "CategoryID" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Category",
                table: "Category",
                column: "ID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Cart",
                table: "Cart",
                columns: new[] { "FoodID", "AppUserId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_AppUser",
                table: "AppUser",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AppRole",
                table: "AppRole",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_AppRoleClaim_AppRole_RoleId",
                table: "AppRoleClaim",
                column: "RoleId",
                principalTable: "AppRole",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AppUserClaim_AppUser_UserId",
                table: "AppUserClaim",
                column: "UserId",
                principalTable: "AppUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AppUserLogin_AppUser_UserId",
                table: "AppUserLogin",
                column: "UserId",
                principalTable: "AppUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AppUserRole_AppRole_RoleId",
                table: "AppUserRole",
                column: "RoleId",
                principalTable: "AppRole",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AppUserRole_AppUser_UserId",
                table: "AppUserRole",
                column: "UserId",
                principalTable: "AppUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AppUserToken_AppUser_UserId",
                table: "AppUserToken",
                column: "UserId",
                principalTable: "AppUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Cart_AppUser_AppUserId",
                table: "Cart",
                column: "AppUserId",
                principalTable: "AppUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Cart_Food_FoodID",
                table: "Cart",
                column: "FoodID",
                principalTable: "Food",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FoodCategory_Category_CategoryID",
                table: "FoodCategory",
                column: "CategoryID",
                principalTable: "Category",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FoodCategory_Food_FoodID",
                table: "FoodCategory",
                column: "FoodID",
                principalTable: "Food",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Order_AppUser_AppUserID",
                table: "Order",
                column: "AppUserID",
                principalTable: "AppUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Order_OrderStatus_OrderStatusID",
                table: "Order",
                column: "OrderStatusID",
                principalTable: "OrderStatus",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Order_Promotion_PromotionID",
                table: "Order",
                column: "PromotionID",
                principalTable: "Promotion",
                principalColumn: "ID",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_OrderDetail_Food_FoodID",
                table: "OrderDetail",
                column: "FoodID",
                principalTable: "Food",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_OrderDetail_Order_OrderID",
                table: "OrderDetail",
                column: "OrderID",
                principalTable: "Order",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Rating_AppUser_AppUserID",
                table: "Rating",
                column: "AppUserID",
                principalTable: "AppUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Rating_Food_FoodID",
                table: "Rating",
                column: "FoodID",
                principalTable: "Food",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AppRoleClaim_AppRole_RoleId",
                table: "AppRoleClaim");

            migrationBuilder.DropForeignKey(
                name: "FK_AppUserClaim_AppUser_UserId",
                table: "AppUserClaim");

            migrationBuilder.DropForeignKey(
                name: "FK_AppUserLogin_AppUser_UserId",
                table: "AppUserLogin");

            migrationBuilder.DropForeignKey(
                name: "FK_AppUserRole_AppRole_RoleId",
                table: "AppUserRole");

            migrationBuilder.DropForeignKey(
                name: "FK_AppUserRole_AppUser_UserId",
                table: "AppUserRole");

            migrationBuilder.DropForeignKey(
                name: "FK_AppUserToken_AppUser_UserId",
                table: "AppUserToken");

            migrationBuilder.DropForeignKey(
                name: "FK_Cart_AppUser_AppUserId",
                table: "Cart");

            migrationBuilder.DropForeignKey(
                name: "FK_Cart_Food_FoodID",
                table: "Cart");

            migrationBuilder.DropForeignKey(
                name: "FK_FoodCategory_Category_CategoryID",
                table: "FoodCategory");

            migrationBuilder.DropForeignKey(
                name: "FK_FoodCategory_Food_FoodID",
                table: "FoodCategory");

            migrationBuilder.DropForeignKey(
                name: "FK_Order_AppUser_AppUserID",
                table: "Order");

            migrationBuilder.DropForeignKey(
                name: "FK_Order_OrderStatus_OrderStatusID",
                table: "Order");

            migrationBuilder.DropForeignKey(
                name: "FK_Order_Promotion_PromotionID",
                table: "Order");

            migrationBuilder.DropForeignKey(
                name: "FK_OrderDetail_Food_FoodID",
                table: "OrderDetail");

            migrationBuilder.DropForeignKey(
                name: "FK_OrderDetail_Order_OrderID",
                table: "OrderDetail");

            migrationBuilder.DropForeignKey(
                name: "FK_Rating_AppUser_AppUserID",
                table: "Rating");

            migrationBuilder.DropForeignKey(
                name: "FK_Rating_Food_FoodID",
                table: "Rating");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Rating",
                table: "Rating");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Promotion",
                table: "Promotion");

            migrationBuilder.DropPrimaryKey(
                name: "PK_OrderStatus",
                table: "OrderStatus");

            migrationBuilder.DropPrimaryKey(
                name: "PK_OrderDetail",
                table: "OrderDetail");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Order",
                table: "Order");

            migrationBuilder.DropPrimaryKey(
                name: "PK_FoodCategory",
                table: "FoodCategory");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Food",
                table: "Food");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Category",
                table: "Category");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Cart",
                table: "Cart");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AppUser",
                table: "AppUser");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AppRole",
                table: "AppRole");

            migrationBuilder.RenameTable(
                name: "Rating",
                newName: "Ra");

            migrationBuilder.RenameTable(
                name: "Promotion",
                newName: "Promotions");

            migrationBuilder.RenameTable(
                name: "OrderStatus",
                newName: "OrderStatuses");

            migrationBuilder.RenameTable(
                name: "OrderDetail",
                newName: "OrderDetails");

            migrationBuilder.RenameTable(
                name: "Order",
                newName: "Orders");

            migrationBuilder.RenameTable(
                name: "FoodCategory",
                newName: "FoodCategories");

            migrationBuilder.RenameTable(
                name: "Food",
                newName: "Foods");

            migrationBuilder.RenameTable(
                name: "Category",
                newName: "Categories");

            migrationBuilder.RenameTable(
                name: "Cart",
                newName: "Carts");

            migrationBuilder.RenameTable(
                name: "AppUser",
                newName: "AspNetUsers");

            migrationBuilder.RenameTable(
                name: "AppRole",
                newName: "AspNetRoles");

            migrationBuilder.RenameIndex(
                name: "IX_Rating_FoodID",
                table: "Ra",
                newName: "IX_Ra_FoodID");

            migrationBuilder.RenameIndex(
                name: "IX_OrderDetail_FoodID",
                table: "OrderDetails",
                newName: "IX_OrderDetails_FoodID");

            migrationBuilder.RenameIndex(
                name: "IX_Order_PromotionID",
                table: "Orders",
                newName: "IX_Orders_PromotionID");

            migrationBuilder.RenameIndex(
                name: "IX_Order_OrderStatusID",
                table: "Orders",
                newName: "IX_Orders_OrderStatusID");

            migrationBuilder.RenameIndex(
                name: "IX_Order_AppUserID",
                table: "Orders",
                newName: "IX_Orders_AppUserID");

            migrationBuilder.RenameIndex(
                name: "IX_FoodCategory_CategoryID",
                table: "FoodCategories",
                newName: "IX_FoodCategories_CategoryID");

            migrationBuilder.RenameIndex(
                name: "IX_Cart_AppUserId",
                table: "Carts",
                newName: "IX_Carts_AppUserId");

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotions",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 17, 23, 25, 35, 20, DateTimeKind.Local).AddTicks(1020),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 675, DateTimeKind.Local).AddTicks(1031));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotions",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 17, 23, 25, 35, 20, DateTimeKind.Local).AddTicks(1556),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 675, DateTimeKind.Local).AddTicks(1533));

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedDate",
                table: "Promotions",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 3, 17, 23, 25, 35, 18, DateTimeKind.Local).AddTicks(375),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 3, 17, 23, 46, 5, 673, DateTimeKind.Local).AddTicks(6249));

            migrationBuilder.AddPrimaryKey(
                name: "PK_Ra",
                table: "Ra",
                columns: new[] { "AppUserID", "FoodID" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Promotions",
                table: "Promotions",
                column: "ID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_OrderStatuses",
                table: "OrderStatuses",
                column: "ID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_OrderDetails",
                table: "OrderDetails",
                columns: new[] { "OrderID", "FoodID" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Orders",
                table: "Orders",
                column: "ID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_FoodCategories",
                table: "FoodCategories",
                columns: new[] { "FoodID", "CategoryID" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Foods",
                table: "Foods",
                column: "ID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Categories",
                table: "Categories",
                column: "ID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Carts",
                table: "Carts",
                columns: new[] { "FoodID", "AppUserId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_AspNetUsers",
                table: "AspNetUsers",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AspNetRoles",
                table: "AspNetRoles",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_AppRoleClaim_AspNetRoles_RoleId",
                table: "AppRoleClaim",
                column: "RoleId",
                principalTable: "AspNetRoles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AppUserClaim_AspNetUsers_UserId",
                table: "AppUserClaim",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AppUserLogin_AspNetUsers_UserId",
                table: "AppUserLogin",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AppUserRole_AspNetRoles_RoleId",
                table: "AppUserRole",
                column: "RoleId",
                principalTable: "AspNetRoles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AppUserRole_AspNetUsers_UserId",
                table: "AppUserRole",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AppUserToken_AspNetUsers_UserId",
                table: "AppUserToken",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Carts_AspNetUsers_AppUserId",
                table: "Carts",
                column: "AppUserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Carts_Foods_FoodID",
                table: "Carts",
                column: "FoodID",
                principalTable: "Foods",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FoodCategories_Categories_CategoryID",
                table: "FoodCategories",
                column: "CategoryID",
                principalTable: "Categories",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FoodCategories_Foods_FoodID",
                table: "FoodCategories",
                column: "FoodID",
                principalTable: "Foods",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_OrderDetails_Foods_FoodID",
                table: "OrderDetails",
                column: "FoodID",
                principalTable: "Foods",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_OrderDetails_Orders_OrderID",
                table: "OrderDetails",
                column: "OrderID",
                principalTable: "Orders",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_AspNetUsers_AppUserID",
                table: "Orders",
                column: "AppUserID",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_OrderStatuses_OrderStatusID",
                table: "Orders",
                column: "OrderStatusID",
                principalTable: "OrderStatuses",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_Promotions_PromotionID",
                table: "Orders",
                column: "PromotionID",
                principalTable: "Promotions",
                principalColumn: "ID",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Ra_AspNetUsers_AppUserID",
                table: "Ra",
                column: "AppUserID",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Ra_Foods_FoodID",
                table: "Ra",
                column: "FoodID",
                principalTable: "Foods",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
