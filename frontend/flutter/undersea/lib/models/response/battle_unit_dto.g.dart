// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_unit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BattleUnitDto _$BattleUnitDtoFromJson(Map<String, dynamic> json) {
  return BattleUnitDto(
    iconImageUrl: json['iconImageUrl'] as String?,
    id: json['id'] as int,
    level: json['level'] as int,
    name: json['name'] as String,
    count: json['count'] as int,
    event: json['event'] == null
        ? null
        : EventDto.fromJson(json['event'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BattleUnitDtoToJson(BattleUnitDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
      'level': instance.level,
      'iconImageUrl': instance.iconImageUrl,
      'event': instance.event,
    };
