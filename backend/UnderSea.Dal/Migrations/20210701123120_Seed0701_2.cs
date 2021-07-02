using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class Seed0701_2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Countries",
                columns: new[] { "Id", "Coral", "MaxUnitCount", "Name", "OwnerId", "Pearl", "Population", "WorldId", "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[,]
                {
                    { 1, 10000, 100, "Center", "af378505-14cb-4f49-bb01-ba2c8fdef77d", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 2, 10000, 100, "Melrose", "72ff37e8-5888-47c6-9ad7-15844a6449b1", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 3, 10000, 100, "Gale", "a63a97aa-4ae8-4185-8621-be02286b1542", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 4, 10000, 100, "Algoma", "c4393fff-8d3a-4508-9245-794916e9e997", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 5, 10000, 100, "Carioca", "cbbd70fb-06cd-4368-af10-93c237980d8c", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 6, 10000, 100, "Norway Maple", "392a9574-11a7-4f01-add1-4980933cc7a6", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 7, 10000, 100, "Melody", "bf37d8cc-0744-4054-9fe1-603e6829799a", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 8, 10000, 100, "Kipling", "488d40fe-e2c5-41e3-b2d9-dea16b7c2897", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 9, 10000, 100, "Londonderry", "0b62f843-4357-423b-83d0-a2506ac91d5c", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 10, 10000, 100, "Arkansas", "c0b59d8d-58cc-4a54-a045-bf2a9341c658", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
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
        }
    }
}
