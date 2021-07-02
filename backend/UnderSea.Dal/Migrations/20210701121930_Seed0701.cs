using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace UnderSea.Dal.Migrations
{
    public partial class Seed0701 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DeviceCodes");

            migrationBuilder.DropTable(
                name: "PersistedGrants");

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Upgrades",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AddColumn<string>(
                name: "ImageUrl",
                table: "Upgrades",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Units",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AddColumn<string>(
                name: "ImageUrl",
                table: "Units",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Effects",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Countries",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Buildings",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50);

            migrationBuilder.AddColumn<string>(
                name: "IconImageUrl",
                table: "Buildings",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ImageUrl",
                table: "Buildings",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Buildings",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "IconImageUrl", "ImageUrl" },
                values: new object[] { "https://underseastorage.blob.core.windows.net/buildingicons/flowcontrol.png", "https://underseastorage.blob.core.windows.net/buildings/flowcontrol_hd.png" });

            migrationBuilder.UpdateData(
                table: "Buildings",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "IconImageUrl", "ImageUrl" },
                values: new object[] { "https://underseastorage.blob.core.windows.net/buildingicons/castle.png", "https://underseastorage.blob.core.windows.net/buildings/castle_hd.png" });

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 1,
                column: "ImageUrl",
                value: "https://underseastorage.blob.core.windows.net/units/seal.svg");

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 2,
                column: "ImageUrl",
                value: "https://underseastorage.blob.core.windows.net/units/seahorse.svg");

            migrationBuilder.UpdateData(
                table: "Units",
                keyColumn: "Id",
                keyValue: 3,
                column: "ImageUrl",
                value: "https://underseastorage.blob.core.windows.net/units/shark.svg");

            migrationBuilder.UpdateData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 1,
                column: "ImageUrl",
                value: "https://underseastorage.blob.core.windows.net/upgrades/tractor.png");

            migrationBuilder.UpdateData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 2,
                column: "ImageUrl",
                value: "https://underseastorage.blob.core.windows.net/upgrades/submarine.png");

            migrationBuilder.UpdateData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 3,
                column: "ImageUrl",
                value: "https://underseastorage.blob.core.windows.net/upgrades/coral_wall.png");

            migrationBuilder.UpdateData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 4,
                column: "ImageUrl",
                value: "https://underseastorage.blob.core.windows.net/upgrades/sonar.png");

            migrationBuilder.UpdateData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 5,
                column: "ImageUrl",
                value: "https://underseastorage.blob.core.windows.net/upgrades/seastar.png");

            migrationBuilder.UpdateData(
                table: "Upgrades",
                keyColumn: "Id",
                keyValue: 6,
                column: "ImageUrl",
                value: "https://underseastorage.blob.core.windows.net/upgrades/potion.png");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ImageUrl",
                table: "Upgrades");

            migrationBuilder.DropColumn(
                name: "ImageUrl",
                table: "Units");

            migrationBuilder.DropColumn(
                name: "IconImageUrl",
                table: "Buildings");

            migrationBuilder.DropColumn(
                name: "ImageUrl",
                table: "Buildings");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Upgrades",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Units",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Effects",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Countries",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Buildings",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.CreateTable(
                name: "DeviceCodes",
                columns: table => new
                {
                    UserCode = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    ClientId = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    CreationTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Data = table.Column<string>(type: "nvarchar(max)", maxLength: 50000, nullable: false),
                    Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    DeviceCode = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Expiration = table.Column<DateTime>(type: "datetime2", nullable: false),
                    SessionId = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    SubjectId = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DeviceCodes", x => x.UserCode);
                });

            migrationBuilder.CreateTable(
                name: "PersistedGrants",
                columns: table => new
                {
                    Key = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    ClientId = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    ConsumedTime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreationTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Data = table.Column<string>(type: "nvarchar(max)", maxLength: 50000, nullable: false),
                    Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    Expiration = table.Column<DateTime>(type: "datetime2", nullable: true),
                    SessionId = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    SubjectId = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    Type = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PersistedGrants", x => x.Key);
                });

            migrationBuilder.InsertData(
                table: "Countries",
                columns: new[] { "Id", "Coral", "MaxUnitCount", "Name", "OwnerId", "Pearl", "Population", "WorldId", "FightPoint_AttackPointMultiplier", "FightPoint_DefensePointMultiplier", "Production_BaseCoralProduction", "Production_BasePearlProduction", "Production_CoralProductionMultiplier", "Production_PearlProductionMultiplier" },
                values: new object[,]
                {
                    { 1, 10000, 100, "Center", "af378505-14cb-4f49-bb01-ba2c8fdef77d", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 2, 10000, 100, "Melrose", "72ff37e8-5888-47c6-9ad7-15844a6449b1", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 3, 10000, 100, "Gale", "a63a97aa-4ae8-4185-8621-be02286b1542", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 4, 10000, 100, "Algoma", "c4393fff-8d3a-4508-9245-794916e9e997", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 5, 10000, 100, "Carioca", "cbbd70fb-06cd-4368-af10-93c237980d8c", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 6, 10000, 100, "Norway Maple", "392a9574-11a7-4f01-add1-4980933cc7a6", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 7, 10000, 100, "Melody", "bf37d8cc-0744-4054-9fe1-603e6829799a", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 8, 10000, 100, "Kipling", "488d40fe-e2c5-41e3-b2d9-dea16b7c2897", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 9, 10000, 100, "Londonderry", "0b62f843-4357-423b-83d0-a2506ac91d5c", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 },
                    { 10, 10000, 100, "Arkansas", "c0b59d8d-58cc-4a54-a045-bf2a9341c658", 10000, 100, 1, 1.0, 1.0, 10, 200, 1.0, 1.0 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_DeviceCodes_DeviceCode",
                table: "DeviceCodes",
                column: "DeviceCode",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_DeviceCodes_Expiration",
                table: "DeviceCodes",
                column: "Expiration");

            migrationBuilder.CreateIndex(
                name: "IX_PersistedGrants_Expiration",
                table: "PersistedGrants",
                column: "Expiration");

            migrationBuilder.CreateIndex(
                name: "IX_PersistedGrants_SubjectId_ClientId_Type",
                table: "PersistedGrants",
                columns: new[] { "SubjectId", "ClientId", "Type" });

            migrationBuilder.CreateIndex(
                name: "IX_PersistedGrants_SubjectId_SessionId_Type",
                table: "PersistedGrants",
                columns: new[] { "SubjectId", "SessionId", "Type" });
        }
    }
}
