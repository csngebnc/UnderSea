using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class ActiveConstructionNewConnection : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ActiveConstructions_CountryBuildings_CountryBuildingId",
                table: "ActiveConstructions");

            migrationBuilder.RenameColumn(
                name: "CountryBuildingId",
                table: "ActiveConstructions",
                newName: "CountryId");

            migrationBuilder.RenameIndex(
                name: "IX_ActiveConstructions_CountryBuildingId",
                table: "ActiveConstructions",
                newName: "IX_ActiveConstructions_CountryId");

            migrationBuilder.AddColumn<int>(
                name: "BuildingId",
                table: "ActiveConstructions",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_ActiveConstructions_BuildingId",
                table: "ActiveConstructions",
                column: "BuildingId");

            migrationBuilder.AddForeignKey(
                name: "FK_ActiveConstructions_Buildings_BuildingId",
                table: "ActiveConstructions",
                column: "BuildingId",
                principalTable: "Buildings",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ActiveConstructions_Countries_CountryId",
                table: "ActiveConstructions",
                column: "CountryId",
                principalTable: "Countries",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ActiveConstructions_Buildings_BuildingId",
                table: "ActiveConstructions");

            migrationBuilder.DropForeignKey(
                name: "FK_ActiveConstructions_Countries_CountryId",
                table: "ActiveConstructions");

            migrationBuilder.DropIndex(
                name: "IX_ActiveConstructions_BuildingId",
                table: "ActiveConstructions");

            migrationBuilder.DropColumn(
                name: "BuildingId",
                table: "ActiveConstructions");

            migrationBuilder.RenameColumn(
                name: "CountryId",
                table: "ActiveConstructions",
                newName: "CountryBuildingId");

            migrationBuilder.RenameIndex(
                name: "IX_ActiveConstructions_CountryId",
                table: "ActiveConstructions",
                newName: "IX_ActiveConstructions_CountryBuildingId");

            migrationBuilder.AddForeignKey(
                name: "FK_ActiveConstructions_CountryBuildings_CountryBuildingId",
                table: "ActiveConstructions",
                column: "CountryBuildingId",
                principalTable: "CountryBuildings",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
