import 'package:json_annotation/json_annotation.dart';
import 'package:undersea/models/response/battle_unit_dto.dart';
import 'package:undersea/models/response/building_info_dto.dart';

part 'country_details_dto.g.dart';

@JsonSerializable()
class CountryDetailsDto {
  int unitId;
  int maxUnitCount;
  List<BattleUnitDto>? units;
  int coral;
  int pearl;
  int currentCoralProduction;
  int currentPearlProduction;
  int population;
  bool hasSonarCanon;
  List<BuildingInfoDto>? buildings;

  CountryDetailsDto(
      {required this.unitId,
      required this.maxUnitCount,
      required this.coral,
      required this.currentCoralProduction,
      required this.currentPearlProduction,
      required this.pearl,
      required this.population,
      this.buildings,
      this.units,
      required this.hasSonarCanon});

  factory CountryDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$CountryDetailsDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CountryDetailsDtoToJson(this);
}
