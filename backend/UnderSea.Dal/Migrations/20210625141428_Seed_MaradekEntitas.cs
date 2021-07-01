using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class Seed_MaradekEntitas : Migration
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
                table: "Effects",
                columns: new[] { "Id", "effect_type", "Name" },
                values: new object[,]
                {
                    { 9, "upgrade_effect_alchemy", "Növeli a beszedett adót 30%-kal" },
                    { 8, "upgrade_effect_martialart", "Növeli a védelmi és támadóerőt pontokat 10%-kal" },
                    { 1, "effect_population", "50 lakost ad a népességhez" },
                    { 4, "upgrade_effect_mudtractor", "Növeli a korall termesztést 10%-kal" },
                    { 7, "upgrade_effect_sonarcannon", "Növeli a támadó pontokat 20%-kal" },
                    { 3, "effect_military", "200 egység katonának nyújt szállást" },
                    { 6, "upgrade_effect_coralwall", "Növeli a védelmi pontokat 20%-kal" },
                    { 2, "effect_coral", "200 korallt termel körönként" },
                    { 5, "upgrade_effect_mudcombine", "Növeli a korall termesztést 15%-kal" }
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
                table: "Upgrades",
                columns: new[] { "Id", "Name", "UpgradeTime" },
                values: new object[,]
                {
                    { 5, "Vízalatti harcművészetek", 15 },
                    { 1, "Iszaptraktor", 15 },
                    { 2, "Iszapkombájn", 15 },
                    { 3, "Korallfal", 15 },
                    { 4, "Szonárágyú", 15 },
                    { 6, "Alkímia", 15 }
                });

            migrationBuilder.InsertData(
                table: "BuildingEffects",
                columns: new[] { "BuildingId", "EffectId" },
                values: new object[,]
                {
                    { 1, 2 },
                    { 2, 3 },
                    { 1, 1 }
                });

            migrationBuilder.InsertData(
                table: "UpgradeEffects",
                columns: new[] { "EffectId", "UpgradeId" },
                values: new object[,]
                {
                    { 4, 1 },
                    { 5, 2 },
                    { 6, 3 },
                    { 7, 4 },
                    { 8, 5 },
                    { 9, 6 }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "BuildingEffects",
                keyColumns: new[] { "BuildingId", "EffectId" },
                keyValues: new object[] { 1, 1 });

            migrationBuilder.DeleteData(
                table: "BuildingEffects",
                keyColumns: new[] { "BuildingId", "EffectId" },
                keyValues: new object[] { 1, 2 });

            migrationBuilder.DeleteData(
                table: "BuildingEffects",
                keyColumns: new[] { "BuildingId", "EffectId" },
                keyValues: new object[] { 2, 3 });

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
                table: "UpgradeEffects",
                keyColumns: new[] { "EffectId", "UpgradeId" },
                keyValues: new object[] { 4, 1 });

            migrationBuilder.DeleteData(
                table: "UpgradeEffects",
                keyColumns: new[] { "EffectId", "UpgradeId" },
                keyValues: new object[] { 5, 2 });

            migrationBuilder.DeleteData(
                table: "UpgradeEffects",
                keyColumns: new[] { "EffectId", "UpgradeId" },
                keyValues: new object[] { 6, 3 });

            migrationBuilder.DeleteData(
                table: "UpgradeEffects",
                keyColumns: new[] { "EffectId", "UpgradeId" },
                keyValues: new object[] { 7, 4 });

            migrationBuilder.DeleteData(
                table: "UpgradeEffects",
                keyColumns: new[] { "EffectId", "UpgradeId" },
                keyValues: new object[] { 8, 5 });

            migrationBuilder.DeleteData(
                table: "UpgradeEffects",
                keyColumns: new[] { "EffectId", "UpgradeId" },
                keyValues: new object[] { 9, 6 });

            migrationBuilder.DeleteData(
                table: "Buildings",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Buildings",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 6);
        }
    }
}
