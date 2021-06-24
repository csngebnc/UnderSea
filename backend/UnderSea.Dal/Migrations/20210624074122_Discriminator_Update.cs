using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class Discriminator_Update : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "effect_type",
                table: "Effects",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.CreateTable(
                name: "ActiveUpgradings",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CountryId = table.Column<int>(type: "int", nullable: false),
                    UpgradeId = table.Column<int>(type: "int", nullable: false),
                    EstimatedFinish = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ActiveUpgradings", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ActiveUpgradings_Countries_CountryId",
                        column: x => x.CountryId,
                        principalTable: "Countries",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ActiveUpgradings_Upgrades_UpgradeId",
                        column: x => x.UpgradeId,
                        principalTable: "Upgrades",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ActiveUpgradings_CountryId",
                table: "ActiveUpgradings",
                column: "CountryId");

            migrationBuilder.CreateIndex(
                name: "IX_ActiveUpgradings_UpgradeId",
                table: "ActiveUpgradings",
                column: "UpgradeId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ActiveUpgradings");

            migrationBuilder.AlterColumn<string>(
                name: "effect_type",
                table: "Effects",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(200)",
                oldMaxLength: 200);
        }
    }
}
