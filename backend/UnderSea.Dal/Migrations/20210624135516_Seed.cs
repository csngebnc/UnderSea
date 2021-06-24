using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class Seed : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.InsertData(
                table: "World",
                columns: new[] { "Id", "Round" },
                values: new object[] { 1, 1 });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.DeleteData(
                table: "World",
                keyColumn: "Id",
                keyValue: 1);
        }
    }
}
