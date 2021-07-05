using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class Spy : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "SpyReports",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SpySenderCountryId = table.Column<int>(type: "int", nullable: false),
                    SpiedCountryId = table.Column<int>(type: "int", nullable: false),
                    NumberOfSpies = table.Column<int>(type: "int", nullable: false),
                    DefensePoints = table.Column<int>(type: "int", nullable: true),
                    WinnerId = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    Round = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SpyReports", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SpyReports_AspNetUsers_WinnerId",
                        column: x => x.WinnerId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_SpyReports_Countries_SpiedCountryId",
                        column: x => x.SpiedCountryId,
                        principalTable: "Countries",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SpyReports_Countries_SpySenderCountryId",
                        column: x => x.SpySenderCountryId,
                        principalTable: "Countries",
                        principalColumn: "Id");
                });

            migrationBuilder.InsertData(
                table: "Units",
                columns: new[] { "Id", "AttackPoint", "DefensePoint", "ImageUrl", "MercenaryPerRound", "Name", "Price", "SupplyPerRound" },
                values: new object[] { 4, 0, 0, "https://underseastorage.blob.core.windows.net/units/shark.svg", 1, "Felfedező", 50, 1 });

            migrationBuilder.CreateIndex(
                name: "IX_SpyReports_SpiedCountryId",
                table: "SpyReports",
                column: "SpiedCountryId");

            migrationBuilder.CreateIndex(
                name: "IX_SpyReports_SpySenderCountryId",
                table: "SpyReports",
                column: "SpySenderCountryId");

            migrationBuilder.CreateIndex(
                name: "IX_SpyReports_WinnerId",
                table: "SpyReports",
                column: "WinnerId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "SpyReports");

            migrationBuilder.DeleteData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 4);
        }
    }
}
