using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class Materials : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Price",
                table: "Units");

            migrationBuilder.DropColumn(
                name: "Coral",
                table: "Countries");

            migrationBuilder.DropColumn(
                name: "Pearl",
                table: "Countries");

            migrationBuilder.DropColumn(
                name: "Production_BaseCoralProduction",
                table: "Countries");

            migrationBuilder.DropColumn(
                name: "Production_BasePearlProduction",
                table: "Countries");

            migrationBuilder.DropColumn(
                name: "Production_CoralProductionMultiplier",
                table: "Countries");

            migrationBuilder.DropColumn(
                name: "Production_PearlProductionMultiplier",
                table: "Countries");

            migrationBuilder.DropColumn(
                name: "Price",
                table: "Buildings");

            migrationBuilder.CreateTable(
                name: "Materials",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    material_type = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Materials", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "BuildingMaterials",
                columns: table => new
                {
                    BuildingId = table.Column<int>(type: "int", nullable: false),
                    MaterialId = table.Column<int>(type: "int", nullable: false),
                    Amount = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BuildingMaterials", x => new { x.BuildingId, x.MaterialId });
                    table.ForeignKey(
                        name: "FK_BuildingMaterials_Buildings_BuildingId",
                        column: x => x.BuildingId,
                        principalTable: "Buildings",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_BuildingMaterials_Materials_MaterialId",
                        column: x => x.MaterialId,
                        principalTable: "Materials",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CountryMaterials",
                columns: table => new
                {
                    CountryId = table.Column<int>(type: "int", nullable: false),
                    MaterialId = table.Column<int>(type: "int", nullable: false),
                    Amount = table.Column<int>(type: "int", nullable: false),
                    BaseProduction = table.Column<int>(type: "int", nullable: false),
                    Multiplier = table.Column<double>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CountryMaterials", x => new { x.CountryId, x.MaterialId });
                    table.ForeignKey(
                        name: "FK_CountryMaterials_Countries_CountryId",
                        column: x => x.CountryId,
                        principalTable: "Countries",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CountryMaterials_Materials_MaterialId",
                        column: x => x.MaterialId,
                        principalTable: "Materials",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UnitMaterials",
                columns: table => new
                {
                    UnitId = table.Column<int>(type: "int", nullable: false),
                    MaterialId = table.Column<int>(type: "int", nullable: false),
                    Amount = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UnitMaterials", x => new { x.UnitId, x.MaterialId });
                    table.ForeignKey(
                        name: "FK_UnitMaterials_Materials_MaterialId",
                        column: x => x.MaterialId,
                        principalTable: "Materials",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UnitMaterials_Units_UnitId",
                        column: x => x.UnitId,
                        principalTable: "Units",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Buildings",
                columns: new[] { "Id", "ConstructionTime", "IconImageUrl", "ImageUrl", "Name" },
                values: new object[] { 3, 5, "https://underseastorage.blob.core.windows.net/buildingicons/stone_mine.png", "https://underseastorage.blob.core.windows.net/buildings/stone_mine.png", "Kőbánya" });

            migrationBuilder.InsertData(
                table: "Effects",
                columns: new[] { "Id", "effect_type", "Name" },
                values: new object[] { 10, "effect_stone", "25 követ termel körönként" });

            migrationBuilder.InsertData(
                table: "Materials",
                columns: new[] { "Id", "material_type", "Name" },
                values: new object[,]
                {
                    { 1, "material_pearl", "gyöngy" },
                    { 2, "material_coral", "korall" },
                    { 3, "material_stone", "kő" }
                });

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 4,
                column: "ImageUrl",
                value: "https://underseastorage.blob.core.windows.net/units/spy.png");

            migrationBuilder.InsertData(
                table: "BuildingEffects",
                columns: new[] { "BuildingId", "EffectId" },
                values: new object[] { 3, 10 });

            migrationBuilder.InsertData(
                table: "BuildingMaterials",
                columns: new[] { "BuildingId", "MaterialId", "Amount" },
                values: new object[,]
                {
                    { 1, 1, 1000 },
                    { 2, 1, 1000 },
                    { 3, 1, 1000 },
                    { 1, 3, 50 },
                    { 2, 3, 50 }
                });

            migrationBuilder.InsertData(
                table: "CountryMaterials",
                columns: new[] { "CountryId", "MaterialId", "Amount", "BaseProduction", "Multiplier" },
                values: new object[,]
                {
                    { 6, 2, 0, 0, 1.0 },
                    { 7, 2, 0, 0, 1.0 },
                    { 8, 2, 0, 0, 1.0 },
                    { 9, 2, 0, 0, 1.0 },
                    { 10, 2, 0, 0, 1.0 },
                    { 2, 3, 0, 0, 1.0 },
                    { 5, 2, 0, 0, 1.0 },
                    { 3, 3, 0, 0, 1.0 },
                    { 4, 3, 0, 0, 1.0 },
                    { 5, 3, 0, 0, 1.0 },
                    { 6, 3, 0, 0, 1.0 },
                    { 7, 3, 0, 0, 1.0 },
                    { 8, 3, 0, 0, 1.0 },
                    { 1, 3, 0, 0, 1.0 },
                    { 4, 2, 0, 0, 1.0 },
                    { 2, 2, 0, 0, 1.0 },
                    { 9, 3, 0, 0, 1.0 },
                    { 1, 1, 5000, 200, 1.0 },
                    { 2, 1, 5000, 200, 1.0 },
                    { 3, 1, 5000, 200, 1.0 },
                    { 4, 1, 5000, 200, 1.0 },
                    { 5, 1, 5000, 200, 1.0 },
                    { 6, 1, 5000, 200, 1.0 },
                    { 7, 1, 5000, 200, 1.0 },
                    { 8, 1, 5000, 200, 1.0 },
                    { 9, 1, 5000, 200, 1.0 },
                    { 10, 1, 5000, 200, 1.0 },
                    { 1, 2, 0, 0, 1.0 },
                    { 3, 2, 0, 0, 1.0 },
                    { 10, 3, 0, 0, 1.0 }
                });

            migrationBuilder.InsertData(
                table: "UnitMaterials",
                columns: new[] { "MaterialId", "UnitId", "Amount" },
                values: new object[,]
                {
                    { 1, 1, 50 },
                    { 1, 2, 50 },
                    { 1, 3, 100 },
                    { 1, 4, 50 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_BuildingMaterials_MaterialId",
                table: "BuildingMaterials",
                column: "MaterialId");

            migrationBuilder.CreateIndex(
                name: "IX_CountryMaterials_MaterialId",
                table: "CountryMaterials",
                column: "MaterialId");

            migrationBuilder.CreateIndex(
                name: "IX_UnitMaterials_MaterialId",
                table: "UnitMaterials",
                column: "MaterialId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BuildingMaterials");

            migrationBuilder.DropTable(
                name: "CountryMaterials");

            migrationBuilder.DropTable(
                name: "UnitMaterials");

            migrationBuilder.DropTable(
                name: "Materials");

            migrationBuilder.DeleteData(
                table: "BuildingEffects",
                keyColumns: new[] { "BuildingId", "EffectId" },
                keyValues: new object[] { 3, 10 });

            migrationBuilder.DeleteData(
                table: "Buildings",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Effects",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.AddColumn<int>(
                name: "Price",
                table: "Units",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Coral",
                table: "Countries",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Pearl",
                table: "Countries",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Production_BaseCoralProduction",
                table: "Countries",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Production_BasePearlProduction",
                table: "Countries",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<double>(
                name: "Production_CoralProductionMultiplier",
                table: "Countries",
                type: "float",
                nullable: true);

            migrationBuilder.AddColumn<double>(
                name: "Production_PearlProductionMultiplier",
                table: "Countries",
                type: "float",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Price",
                table: "Buildings",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Buildings",
                keyColumn: "Id",
                keyValue: 1,
                column: "Price",
                value: 1000);

            migrationBuilder.UpdateData(
                table: "Buildings",
                keyColumn: "Id",
                keyValue: 2,
                column: "Price",
                value: 1000);

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "Coral", "Pearl", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 10000, 10000, 10, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "Coral", "Pearl", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 10000, 10000, 10, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "Coral", "Pearl", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 10000, 10000, 10, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "Coral", "Pearl", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 10000, 10000, 10, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "Coral", "Pearl", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 10000, 10000, 10, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 6,
                columns: new[] { "Coral", "Pearl", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 10000, 10000, 10, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 7,
                columns: new[] { "Coral", "Pearl", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 10000, 10000, 10, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 8,
                columns: new[] { "Coral", "Pearl", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 10000, 10000, 10, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 9,
                columns: new[] { "Coral", "Pearl", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 10000, 10000, 10, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 10,
                columns: new[] { "Coral", "Pearl", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[] { 10000, 10000, 10, 200, 1.0, 1.0 });

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 1,
                column: "Price",
                value: 50);

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 2,
                column: "Price",
                value: 50);

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 3,
                column: "Price",
                value: 100);

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "ImageUrl", "Price" },
                values: new object[] { "https://underseastorage.blob.core.windows.net/units/shark.svg", 50 });
        }
    }
}
