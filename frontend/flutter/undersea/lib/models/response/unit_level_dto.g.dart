// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_level_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitLevelDto _$UnitLevelDtoFromJson(Map<String, dynamic> json) {
  return UnitLevelDto(
    minimumBattles: json['minimumBattles'] as int,
    attackPoint: json['attackPoint'] as int,
    defensePoint: json['defensePoint'] as int,
    level: json['level'] as int,
  );
}

Map<String, dynamic> _$UnitLevelDtoToJson(UnitLevelDto instance) =>
    <String, dynamic>{
      'minimumBattles': instance.minimumBattles,
      'attackPoint': instance.attackPoint,
      'defensePoint': instance.defensePoint,
      'level': instance.level,
    };
