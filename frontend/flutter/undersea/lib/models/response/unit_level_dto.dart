import 'package:json_annotation/json_annotation.dart';

part 'unit_level_dto.g.dart';

@JsonSerializable()
class UnitLevelDto {
  int minimumBattles;
  int attackPoint;
  int defensePoint;
  int level;

  UnitLevelDto(
      {required this.minimumBattles,
      required this.attackPoint,
      required this.defensePoint,
      required this.level});

  factory UnitLevelDto.fromJson(Map<String, dynamic> json) =>
      _$UnitLevelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UnitLevelDtoToJson(this);
}
