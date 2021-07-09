using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class UnitLevel : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AttackPoint",
                table: "Units");

            migrationBuilder.DropColumn(
                name: "DefensePoint",
                table: "Units");

            migrationBuilder.AddColumn<int>(
                name: "BattlesPlayed",
                table: "CountryUnits",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "BattlesPlayed",
                table: "AttackUnits",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "UnitLevels",
                columns: table => new
                {
                    UnitId = table.Column<int>(type: "int", nullable: false),
                    Level = table.Column<int>(type: "int", nullable: false),
                    MinimumBattles = table.Column<int>(type: "int", nullable: false),
                    AttackPoint = table.Column<int>(type: "int", nullable: false),
                    DefensePoint = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UnitLevels", x => new { x.UnitId, x.Level });
                    table.ForeignKey(
                        name: "FK_UnitLevels_Units_UnitId",
                        column: x => x.UnitId,
                        principalTable: "Units",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "UnitLevels",
                columns: new[] { "Level", "UnitId", "AttackPoint", "DefensePoint", "MinimumBattles" },
                values: new object[,]
                {
                    { 1, 1, 6, 2, 0 },
                    { 2, 1, 8, 3, 3 },
                    { 3, 1, 10, 5, 5 },
                    { 1, 2, 2, 6, 0 },
                    { 2, 2, 3, 8, 3 },
                    { 3, 2, 5, 10, 5 },
                    { 1, 3, 5, 5, 0 },
                    { 2, 3, 7, 7, 3 },
                    { 3, 3, 10, 10, 5 },
                    { 1, 4, 0, 0, 0 },
                    { 1, 5, 0, 0, 0 }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "UnitLevels");

            migrationBuilder.DropColumn(
                name: "BattlesPlayed",
                table: "CountryUnits");

            migrationBuilder.DropColumn(
                name: "BattlesPlayed",
                table: "AttackUnits");

            migrationBuilder.AddColumn<int>(
                name: "AttackPoint",
                table: "Units",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "DefensePoint",
                table: "Units",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "AttackPoint", "DefensePoint" },
                values: new object[] { 6, 2 });

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "AttackPoint", "DefensePoint" },
                values: new object[] { 2, 6 });

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "AttackPoint", "DefensePoint" },
                values: new object[] { 5, 5 });
        }
    }
}
