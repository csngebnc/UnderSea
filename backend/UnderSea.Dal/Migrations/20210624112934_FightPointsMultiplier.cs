using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class FightPointsMultiplier : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "BonusAttackPoint",
                table: "CountryUnits");

            migrationBuilder.DropColumn(
                name: "BonusDefensePoint",
                table: "CountryUnits");

            migrationBuilder.AddColumn<double>(
                name: "FightPoint_AttackPointMultiplier",
                table: "Countries",
                type: "float",
                nullable: true);

            migrationBuilder.AddColumn<double>(
                name: "FightPoint_DefensePointMultiplier",
                table: "Countries",
                type: "float",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "FightPoint_AttackPointMultiplier",
                table: "Countries");

            migrationBuilder.DropColumn(
                name: "FightPoint_DefensePointMultiplier",
                table: "Countries");

            migrationBuilder.AddColumn<int>(
                name: "BonusAttackPoint",
                table: "CountryUnits",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "BonusDefensePoint",
                table: "CountryUnits",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
