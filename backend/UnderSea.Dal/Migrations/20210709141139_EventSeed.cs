using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class EventSeed : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "FightPoint_BonusAttackPoint",
                table: "Countries",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Events",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Events", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "CountryEvents",
                columns: table => new
                {
                    CountryId = table.Column<int>(type: "int", nullable: false),
                    EventId = table.Column<int>(type: "int", nullable: false),
                    EventRound = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CountryEvents", x => new { x.CountryId, x.EventId });
                    table.ForeignKey(
                        name: "FK_CountryEvents_Countries_CountryId",
                        column: x => x.CountryId,
                        principalTable: "Countries",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CountryEvents_Events_EventId",
                        column: x => x.EventId,
                        principalTable: "Events",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "EventEffects",
                columns: table => new
                {
                    EventId = table.Column<int>(type: "int", nullable: false),
                    EffectId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EventEffects", x => new { x.EffectId, x.EventId });
                    table.ForeignKey(
                        name: "FK_EventEffects_Effects_EffectId",
                        column: x => x.EffectId,
                        principalTable: "Effects",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_EventEffects_Events_EventId",
                        column: x => x.EventId,
                        principalTable: "Events",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Effects",
                columns: new[] { "Id", "effect_type", "Name" },
                values: new object[,]
                {
                    { 12, "WaterFire", "Az országodban tűz ütött ki és leégett egy zátonyvár." },
                    { 19, "UnsatisfiedPeople", "Az országodban elégedetlenek az emberek, ezért 50 ember elköltözött és az áramlásirányítójuk lerombolták" },
                    { 16, "SatisfiedUnits", "Katonáid elégedettek ebben a körben, minden katona támadása nő eggyel." },
                    { 18, "SatisfiedPeople", "Az országodban elégedettek az emberek, ezért extra 50 ember költözött be és építettek maguknak egy áramlásirányítót" },
                    { 11, "PlagueEffect", " Az országodban kitört a pestis, elveszítesz 50 embert és egy áramlásirányítót." },
                    { 14, "GoodHarvest", "Minden áramlásirányító 250 korallt ad ebben a körben." },
                    { 13, "Goldmine", "Az embereid felfedeztek egy új aranybányát, kapsz 1000 bónusz gyöngyöt." },
                    { 15, "BadHarvest", "Minden áramlásirányító 150 korallt ad ebben a körben." },
                    { 17, "UnsatisfiedUnits", "Katonáid elégedetlenek ebben a körben, minden katona támadása csökken eggyel." }
                });

            migrationBuilder.InsertData(
                table: "Events",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 9, "Elégedetlen emberek" },
                    { 7, "Elégedetlen katonák" },
                    { 6, "Elégedett katonák" },
                    { 5, "Rossz termés" },
                    { 4, "Jó termés" },
                    { 3, "Aranybánya" },
                    { 2, "Víz alatti tűz" },
                    { 8, "Elégedett emberek" },
                    { 1, "Pestis" }
                });

            migrationBuilder.InsertData(
                table: "EventEffects",
                columns: new[] { "EffectId", "EventId" },
                values: new object[,]
                {
                    { 15, 5 },
                    { 13, 3 },
                    { 14, 4 },
                    { 11, 1 },
                    { 18, 8 },
                    { 16, 6 },
                    { 19, 9 },
                    { 17, 7 },
                    { 12, 2 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_CountryEvents_EventId",
                table: "CountryEvents",
                column: "EventId");

            migrationBuilder.CreateIndex(
                name: "IX_EventEffects_EventId",
                table: "EventEffects",
                column: "EventId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CountryEvents");

            migrationBuilder.DropTable(
                name: "EventEffects");

            migrationBuilder.DropTable(
                name: "Events");

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DropColumn(
                name: "FightPoint_BonusAttackPoint",
                table: "Countries");
        }
    }
}
