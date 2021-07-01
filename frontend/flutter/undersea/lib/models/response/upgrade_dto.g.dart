// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upgrade_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpgradeDto _$UpgradeDtoFromJson(Map<String, dynamic> json) {
  return UpgradeDto(
    effects: (json['effects'] as List<dynamic>?)
        ?.map((e) => EffectDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as int,
    doesExist: json['doesExist'] as bool,
    isUnderContruction: json['isUnderContruction'] as bool,
    name: json['name'] as String,
    remainingTime: json['remainingTime'] as int,
  );
}

Map<String, dynamic> _$UpgradeDtoToJson(UpgradeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'doesExist': instance.doesExist,
      'isUnderContruction': instance.isUnderContruction,
      'remainingTime': instance.remainingTime,
      'effects': instance.effects,
    };
