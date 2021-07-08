// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_unit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyUnitDto _$BuyUnitDtoFromJson(Map<String, dynamic> json) {
  return BuyUnitDto(
    units: (json['units'] as List<dynamic>)
        .map((e) => BuyUnitDetailsDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BuyUnitDtoToJson(BuyUnitDto instance) =>
    <String, dynamic>{
      'units': instance.units,
    };
