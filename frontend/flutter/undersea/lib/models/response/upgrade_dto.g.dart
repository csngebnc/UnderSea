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
    isUnderConstruction: json['isUnderConstruction'] as bool,
    name: json['name'] as String,
    remainingTime: json['remainingTime'] as int,
    imageUrl: json['imageUrl'] as String?,
  );
}

Map<String, dynamic> _$UpgradeDtoToJson(UpgradeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'doesExist': instance.doesExist,
      'isUnderConstruction': instance.isUnderConstruction,
      'remainingTime': instance.remainingTime,
      'imageUrl': instance.imageUrl,
      'effects': instance.effects,
    };
