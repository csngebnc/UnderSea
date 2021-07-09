using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class UnitLevels_Fix : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_CountryUnits",
                table: "CountryUnits");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CountryUnits",
                table: "CountryUnits",
                columns: new[] { "CountryId", "UnitId", "BattlesPlayed" });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_CountryUnits",
                table: "CountryUnits");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CountryUnits",
                table: "CountryUnits",
                columns: new[] { "CountryId", "UnitId" });
        }
    }
}
