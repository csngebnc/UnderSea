// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_spy_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendSpyDto _$SendSpyDtoFromJson(Map<String, dynamic> json) {
  return SendSpyDto(
    spiedCountryId: json['spiedCountryId'] as int,
    spyCount: json['spyCount'] as int,
  );
}

Map<String, dynamic> _$SendSpyDtoToJson(SendSpyDto instance) =>
    <String, dynamic>{
      'spiedCountryId': instance.spiedCountryId,
      'spyCount': instance.spyCount,
    };
