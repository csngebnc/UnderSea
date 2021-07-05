// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_unit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BattleUnitDto _$BattleUnitDtoFromJson(Map<String, dynamic> json) {
  return BattleUnitDto(
    iconImageUrl: json['iconImageUrl'] as String?,
    id: json['id'] as int,
    name: json['name'] as String,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$BattleUnitDtoToJson(BattleUnitDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
      'iconImageUrl': instance.iconImageUrl,
    };
