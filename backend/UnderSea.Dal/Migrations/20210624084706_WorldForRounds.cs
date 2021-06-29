using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class WorldForRounds : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "WorldId",
                table: "Countries",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "World",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Round = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_World", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Countries_WorldId",
                table: "Countries",
                column: "WorldId");

            migrationBuilder.AddForeignKey(
                name: "FK_Countries_World_WorldId",
                table: "Countries",
                column: "WorldId",
                principalTable: "World",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Countries_World_WorldId",
                table: "Countries");

            migrationBuilder.DropTable(
                name: "World");

            migrationBuilder.DropIndex(
                name: "IX_Countries_WorldId",
                table: "Countries");

            migrationBuilder.DropColumn(
                name: "WorldId",
                table: "Countries");
        }
    }
}
