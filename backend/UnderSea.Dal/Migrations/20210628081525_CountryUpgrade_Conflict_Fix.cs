using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class CountryUpgrade_Conflict_Fix : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "EstimatedFinish",
                table: "CountryUpgrades");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "EstimatedFinish",
                table: "CountryUpgrades",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
