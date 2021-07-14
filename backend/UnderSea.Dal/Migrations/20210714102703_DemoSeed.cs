using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class DemoSeed : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "CountryUnits",
                columns: new[] { "BattlesPlayed", "CountryId", "UnitId", "Count" },
                values: new object[,]
                {
                    { 0, 1, 1, 10 },
                    { 3, 1, 1, 6 },
                    { 5, 1, 1, 17 },
                    { 0, 1, 2, 4 },
                    { 5, 1, 2, 10 },
                    { 4, 1, 3, 10 },
                    { 0, 1, 4, 10 },
                    { 0, 1, 5, 10 }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "CountryUnits",
                keyColumns: new[] { "BattlesPlayed", "CountryId", "UnitId" },
                keyValues: new object[] { 0, 1, 1 });

            migrationBuilder.DeleteData(
                table: "CountryUnits",
                keyColumns: new[] { "BattlesPlayed", "CountryId", "UnitId" },
                keyValues: new object[] { 3, 1, 1 });

            migrationBuilder.DeleteData(
                table: "CountryUnits",
                keyColumns: new[] { "BattlesPlayed", "CountryId", "UnitId" },
                keyValues: new object[] { 5, 1, 1 });

            migrationBuilder.DeleteData(
                table: "CountryUnits",
                keyColumns: new[] { "BattlesPlayed", "CountryId", "UnitId" },
                keyValues: new object[] { 0, 1, 2 });

            migrationBuilder.DeleteData(
                table: "CountryUnits",
                keyColumns: new[] { "BattlesPlayed", "CountryId", "UnitId" },
                keyValues: new object[] { 5, 1, 2 });

            migrationBuilder.DeleteData(
                table: "CountryUnits",
                keyColumns: new[] { "BattlesPlayed", "CountryId", "UnitId" },
                keyValues: new object[] { 4, 1, 3 });

            migrationBuilder.DeleteData(
                table: "CountryUnits",
                keyColumns: new[] { "BattlesPlayed", "CountryId", "UnitId" },
                keyValues: new object[] { 0, 1, 4 });

            migrationBuilder.DeleteData(
                table: "CountryUnits",
                keyColumns: new[] { "BattlesPlayed", "CountryId", "UnitId" },
                keyValues: new object[] { 0, 1, 5 });
        }
    }
}
