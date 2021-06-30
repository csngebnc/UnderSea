// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_attack_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendAttackDto _$SendAttackDtoFromJson(Map<String, dynamic> json) {
  return SendAttackDto(
    attackedCountryId: json['attackedCountryId'] as int,
    units: (json['units'] as List<dynamic>)
        .map((e) => AttackUnitDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SendAttackDtoToJson(SendAttackDto instance) =>
    <String, dynamic>{
      'attackedCountryId': instance.attackedCountryId,
      'units': instance.units,
    };
