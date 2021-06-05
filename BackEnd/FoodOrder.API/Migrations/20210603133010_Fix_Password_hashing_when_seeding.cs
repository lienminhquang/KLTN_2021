using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace FoodOrder.API.Migrations
{
    public partial class Fix_Password_hashing_when_seeding : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 3, 20, 30, 9, 310, DateTimeKind.Local).AddTicks(6966),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 3, 20, 18, 17, 50, DateTimeKind.Local).AddTicks(8280));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 3, 20, 30, 9, 312, DateTimeKind.Local).AddTicks(6471),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 3, 20, 18, 17, 52, DateTimeKind.Local).AddTicks(754));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "6682e8eb-cf7a-4a54-a8ee-9fe4cb3c5d71");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "2445637a-03ac-49af-94c9-6f3d4d368b81");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "ad20edcb-1450-4354-a88a-69df305bff67");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "0acebcc0-bfb6-46a9-95e9-834ee41e72dd", "AQAAAAEAACcQAAAAEOhk1dlxZ08l0AWfJbClIC6TQLriDZ72NoHmn9MODLwaox3NMFSLdfJkqnzKmueKWw==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "7bfa3ab3-5d20-4060-bef1-638297e87e2f", "AQAAAAEAACcQAAAAEJSJFg9Wa9X/y0PGThMzcY0ZjWRLXr74k4uPoqjVY5uFRyktzdcRYveLVSTnSRHngg==" });

            migrationBuilder.InsertData(
                table: "AppUserRole",
                columns: new[] { "RoleId", "UserId" },
                values: new object[,]
                {
                    { new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"), new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4") },
                    { new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"), new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684") }
                });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 3, 20, 30, 9, 381, DateTimeKind.Local).AddTicks(8190));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 3, 20, 30, 9, 384, DateTimeKind.Local).AddTicks(1440));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AppUserRole",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"), new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4") });

            migrationBuilder.DeleteData(
                table: "AppUserRole",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"), new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684") });

            migrationBuilder.AlterColumn<DateTime>(
                name: "StartDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 3, 20, 18, 17, 50, DateTimeKind.Local).AddTicks(8280),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 3, 20, 30, 9, 310, DateTimeKind.Local).AddTicks(6966));

            migrationBuilder.AlterColumn<DateTime>(
                name: "EndDate",
                table: "Promotion",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(2021, 6, 3, 20, 18, 17, 52, DateTimeKind.Local).AddTicks(754),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValue: new DateTime(2021, 6, 3, 20, 30, 9, 312, DateTimeKind.Local).AddTicks(6471));

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("1267bf30-8eea-4370-bbcd-12f74e29c656"),
                column: "ConcurrencyStamp",
                value: "76e5598b-30a5-4368-979c-b905e6ee261d");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("74d17d8b-3f91-4d3a-893f-09b4e51e3834"),
                column: "ConcurrencyStamp",
                value: "490c9750-ec77-4a76-824b-e8f5ffe236fd");

            migrationBuilder.UpdateData(
                table: "AppRole",
                keyColumn: "Id",
                keyValue: new Guid("b9e08f48-883c-42dc-a700-da5cf1d81aa3"),
                column: "ConcurrencyStamp",
                value: "2a96c8f2-aef8-4129-80ce-f945a87347c4");

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("b4e253b2-756e-48b8-9c42-b5acb139bed4"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "73252593-d625-4e8d-b7dc-538a4e3d5eab", "AQAAAAEAACcQAAAAEHeXlawf/Gn0kfRXxgSqv06AVf+bdcYQE9es3bsQymi8rEnwCGodDMiA/jlIE3Yrhw==" });

            migrationBuilder.UpdateData(
                table: "AppUser",
                keyColumn: "Id",
                keyValue: new Guid("daeb6f0d-eefe-4250-9ecd-28b3243eb684"),
                columns: new[] { "ConcurrencyStamp", "PasswordHash" },
                values: new object[] { "e499bfe0-7960-485c-91f1-5393e8ecf62f", "AQAAAAEAACcQAAAAEPCVh7ZwZAt+UqpON4U/cwIj0kfvF74tSgUt5B0EeA65L07MTuZ0lvo/S/D6ExTOEQ==" });

            migrationBuilder.UpdateData(
                table: "Order",
                keyColumn: "ID",
                keyValue: 1,
                column: "CreatedDate",
                value: new DateTime(2021, 6, 3, 20, 18, 17, 95, DateTimeKind.Local).AddTicks(4483));

            migrationBuilder.UpdateData(
                table: "Promotion",
                keyColumn: "ID",
                keyValue: 1,
                column: "StartDate",
                value: new DateTime(2021, 6, 3, 20, 18, 17, 96, DateTimeKind.Local).AddTicks(6771));
        }
    }
}
