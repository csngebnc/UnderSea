using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class Hadvezer : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Units",
                columns: new[] { "Id", "AttackPoint", "DefensePoint", "ImageUrl", "MercenaryPerRound", "Name", "SupplyPerRound" },
                values: new object[] { 5, 0, 0, "https://underseastorage.blob.core.windows.net/units/general.png", 4, "Hadvezér", 2 });

            migrationBuilder.InsertData(
                table: "UnitMaterials",
                columns: new[] { "MaterialId", "UnitId", "Amount" },
                values: new object[] { 1, 5, 200 });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "UnitMaterials",
                keyColumns: new[] { "MaterialId", "UnitId" },
                keyValues: new object[] { 1, 5 });

            migrationBuilder.DeleteData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 5);
        }
    }
}
