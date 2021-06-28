using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class SeedFix : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 1.0, 1.0, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 1.0, 1.0, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 1.0, 1.0, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 1.0, 1.0, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 1.0, 1.0, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 6,
                columns: new[] { "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 1.0, 1.0, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 7,
                columns: new[] { "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 1.0, 1.0, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 8,
                columns: new[] { "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 1.0, 1.0, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 9,
                columns: new[] { "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 1.0, 1.0, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 10,
                columns: new[] { "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 1.0, 1.0, 200, 1.0, 1.0 });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
