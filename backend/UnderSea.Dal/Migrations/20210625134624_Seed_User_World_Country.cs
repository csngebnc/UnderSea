using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class Seed_User_World_Country : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Countries_World_WorldId",
                table: "Countries");

            migrationBuilder.DropPrimaryKey(
                name: "PK_World",
                table: "World");

            migrationBuilder.DeleteData(
                table: "Buildings",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Buildings",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.RenameTable(
                name: "World",
                newName: "Worlds");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Worlds",
                table: "Worlds",
                column: "Id");

            migrationBuilder.InsertData(
                table: "AspNetUsers",
                columns: new[] { "Id", "AccessFailedCount", "ConcurrencyStamp", "Email", "EmailConfirmed", "LockoutEnabled", "LockoutEnd", "NormalizedEmail", "NormalizedUserName", "PasswordHash", "PhoneNumber", "PhoneNumberConfirmed", "Points", "SecurityStamp", "TwoFactorEnabled", "UserName" },
                values: new object[,]
                {
                    { "af378505-14cb-4f49-bb01-ba2c8fdef77d", 0, "cfc830af-302f-44b7-a973-805e6439b2ad", null, false, false, null, null, "SSTRAHAN0", "AQAAAAEAACcQAAAAEEKLF5tLrJUpIeFkr0WDBFQ6qYyrHKP4JyYyJHUET8mJFsSSNPZiWHkvC4Fv2AcQmg==", null, false, 0, "RD6YLKPIHDS7MMSLGQ3O7DF5ZNR73XJ2", false, "sstrahan0" },
                    { "72ff37e8-5888-47c6-9ad7-15844a6449b1", 0, "cfc830af-302f-44b7-a973-805e6439b2ad", null, false, false, null, null, "LTIPPIN1", "AQAAAAEAACcQAAAAEEKLF5tLrJUpIeFkr0WDBFQ6qYyrHKP4JyYyJHUET8mJFsSSNPZiWHkvC4Fv2AcQmg==", null, false, 0, "RD6YLKPIHDS7MMSLGQ3O7DF5ZNR73XJ2", false, "ltippin1" },
                    { "a63a97aa-4ae8-4185-8621-be02286b1542", 0, "cfc830af-302f-44b7-a973-805e6439b2ad", null, false, false, null, null, "BLYPTRATT2", "AQAAAAEAACcQAAAAEEKLF5tLrJUpIeFkr0WDBFQ6qYyrHKP4JyYyJHUET8mJFsSSNPZiWHkvC4Fv2AcQmg==", null, false, 0, "RD6YLKPIHDS7MMSLGQ3O7DF5ZNR73XJ2", false, "blyptratt2" },
                    { "c4393fff-8d3a-4508-9245-794916e9e997", 0, "cfc830af-302f-44b7-a973-805e6439b2ad", null, false, false, null, null, "JMELIOR3", "AQAAAAEAACcQAAAAEEKLF5tLrJUpIeFkr0WDBFQ6qYyrHKP4JyYyJHUET8mJFsSSNPZiWHkvC4Fv2AcQmg==", null, false, 0, "RD6YLKPIHDS7MMSLGQ3O7DF5ZNR73XJ2", false, "jmelior3" },
                    { "cbbd70fb-06cd-4368-af10-93c237980d8c", 0, "cfc830af-302f-44b7-a973-805e6439b2ad", null, false, false, null, null, "TMAXWORTHY4", "AQAAAAEAACcQAAAAEEKLF5tLrJUpIeFkr0WDBFQ6qYyrHKP4JyYyJHUET8mJFsSSNPZiWHkvC4Fv2AcQmg==", null, false, 0, "RD6YLKPIHDS7MMSLGQ3O7DF5ZNR73XJ2", false, "tmaxworthy4" },
                    { "392a9574-11a7-4f01-add1-4980933cc7a6", 0, "cfc830af-302f-44b7-a973-805e6439b2ad", null, false, false, null, null, "HCHEVERELL5", "AQAAAAEAACcQAAAAEEKLF5tLrJUpIeFkr0WDBFQ6qYyrHKP4JyYyJHUET8mJFsSSNPZiWHkvC4Fv2AcQmg==", null, false, 0, "RD6YLKPIHDS7MMSLGQ3O7DF5ZNR73XJ2", false, "hcheverell5" },
                    { "bf37d8cc-0744-4054-9fe1-603e6829799a", 0, "cfc830af-302f-44b7-a973-805e6439b2ad", null, false, false, null, null, "GBOSKELL6", "AQAAAAEAACcQAAAAEEKLF5tLrJUpIeFkr0WDBFQ6qYyrHKP4JyYyJHUET8mJFsSSNPZiWHkvC4Fv2AcQmg==", null, false, 0, "RD6YLKPIHDS7MMSLGQ3O7DF5ZNR73XJ2", false, "gboskell6" },
                    { "488d40fe-e2c5-41e3-b2d9-dea16b7c2897", 0, "cfc830af-302f-44b7-a973-805e6439b2ad", null, false, false, null, null, "ERYLETT7", "AQAAAAEAACcQAAAAEEKLF5tLrJUpIeFkr0WDBFQ6qYyrHKP4JyYyJHUET8mJFsSSNPZiWHkvC4Fv2AcQmg==", null, false, 0, "RD6YLKPIHDS7MMSLGQ3O7DF5ZNR73XJ2", false, "erylett7" },
                    { "0b62f843-4357-423b-83d0-a2506ac91d5c", 0, "cfc830af-302f-44b7-a973-805e6439b2ad", null, false, false, null, null, "KSEELY8", "AQAAAAEAACcQAAAAEEKLF5tLrJUpIeFkr0WDBFQ6qYyrHKP4JyYyJHUET8mJFsSSNPZiWHkvC4Fv2AcQmg==", null, false, 0, "RD6YLKPIHDS7MMSLGQ3O7DF5ZNR73XJ2", false, "kseely8" },
                    { "c0b59d8d-58cc-4a54-a045-bf2a9341c658", 0, "cfc830af-302f-44b7-a973-805e6439b2ad", null, false, false, null, null, "HFILINKOV9", "AQAAAAEAACcQAAAAEEKLF5tLrJUpIeFkr0WDBFQ6qYyrHKP4JyYyJHUET8mJFsSSNPZiWHkvC4Fv2AcQmg==", null, false, 0, "RD6YLKPIHDS7MMSLGQ3O7DF5ZNR73XJ2", false, "hfilinkov9" }
                });

            migrationBuilder.InsertData(
                table: "Countries",
                columns: new[] { "Id", "Coral", "MaxUnitCount", "Name", "OwnerId", "Pearl", "Population", "WorldId" },
                values: new object[,]
                {
                    { 1, 10000, 100, "Center", "af378505-14cb-4f49-bb01-ba2c8fdef77d", 10000, 100, 1 },
                    { 2, 10000, 100, "Melrose", "72ff37e8-5888-47c6-9ad7-15844a6449b1", 10000, 100, 1 },
                    { 3, 10000, 100, "Gale", "a63a97aa-4ae8-4185-8621-be02286b1542", 10000, 100, 1 },
                    { 4, 10000, 100, "Algoma", "c4393fff-8d3a-4508-9245-794916e9e997", 10000, 100, 1 },
                    { 5, 10000, 100, "Carioca", "cbbd70fb-06cd-4368-af10-93c237980d8c", 10000, 100, 1 },
                    { 6, 10000, 100, "Norway Maple", "392a9574-11a7-4f01-add1-4980933cc7a6", 10000, 100, 1 },
                    { 7, 10000, 100, "Melody", "bf37d8cc-0744-4054-9fe1-603e6829799a", 10000, 100, 1 },
                    { 8, 10000, 100, "Kipling", "488d40fe-e2c5-41e3-b2d9-dea16b7c2897", 10000, 100, 1 },
                    { 9, 10000, 100, "Londonderry", "0b62f843-4357-423b-83d0-a2506ac91d5c", 10000, 100, 1 },
                    { 10, 10000, 100, "Arkansas", "c0b59d8d-58cc-4a54-a045-bf2a9341c658", 10000, 100, 1 }
                });

            migrationBuilder.AddForeignKey(
                name: "FK_Countries_Worlds_WorldId",
                table: "Countries",
                column: "WorldId",
                principalTable: "Worlds",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Countries_Worlds_WorldId",
                table: "Countries");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Worlds",
                table: "Worlds");

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "0b62f843-4357-423b-83d0-a2506ac91d5c");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "392a9574-11a7-4f01-add1-4980933cc7a6");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "488d40fe-e2c5-41e3-b2d9-dea16b7c2897");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "72ff37e8-5888-47c6-9ad7-15844a6449b1");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "a63a97aa-4ae8-4185-8621-be02286b1542");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "af378505-14cb-4f49-bb01-ba2c8fdef77d");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "bf37d8cc-0744-4054-9fe1-603e6829799a");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "c0b59d8d-58cc-4a54-a045-bf2a9341c658");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "c4393fff-8d3a-4508-9245-794916e9e997");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "cbbd70fb-06cd-4368-af10-93c237980d8c");

            migrationBuilder.RenameTable(
                name: "Worlds",
                newName: "World");

            migrationBuilder.AddPrimaryKey(
                name: "PK_World",
                table: "World",
                column: "Id");

            migrationBuilder.InsertData(
                table: "Buildings",
                columns: new[] { "Id", "ConstructionTime", "Name", "Price" },
                values: new object[,]
                {
                    { 1, 5, "Áramlásirányító", 1000 },
                    { 2, 5, "Zátonyvár", 1000 }
                });

            migrationBuilder.InsertData(
                table: "Units",
                columns: new[] { "Id", "AttackPoint", "DefensePoint", "MercenaryPerRound", "Name", "Price", "SupplyPerRound" },
                values: new object[,]
                {
                    { 1, 6, 2, 1, "Rohamfóka", 50, 1 },
                    { 2, 2, 6, 1, "Csatacsikó", 50, 1 },
                    { 3, 5, 5, 3, "Lézercápa", 100, 2 }
                });

            migrationBuilder.AddForeignKey(
                name: "FK_Countries_World_WorldId",
                table: "Countries",
                column: "WorldId",
                principalTable: "World",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
