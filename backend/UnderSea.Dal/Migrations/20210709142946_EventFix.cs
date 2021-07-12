using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class EventFix : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_CountryEvents",
                table: "CountryEvents");

            migrationBuilder.AddColumn<int>(
                name: "Id",
                table: "CountryEvents",
                type: "int",
                nullable: false,
                defaultValue: 0)
                .Annotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CountryEvents",
                table: "CountryEvents",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_CountryEvents_CountryId",
                table: "CountryEvents",
                column: "CountryId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_CountryEvents",
                table: "CountryEvents");

            migrationBuilder.DropIndex(
                name: "IX_CountryEvents_CountryId",
                table: "CountryEvents");

            migrationBuilder.DropColumn(
                name: "Id",
                table: "CountryEvents");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CountryEvents",
                table: "CountryEvents",
                columns: new[] { "CountryId", "EventId" });
        }
    }
}
