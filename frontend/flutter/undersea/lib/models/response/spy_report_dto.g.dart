// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spy_report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpyReportDto _$SpyReportDtoFromJson(Map<String, dynamic> json) {
  return SpyReportDto(
    spiedCountryName: json['spiedCountryName'] as String?,
    outCome: _$enumDecode(_$FightOutcomeEnumMap, json['outCome']),
    defensePoints: json['defensePoints'] as int?,
    spyReportId: json['spyReportId'] as int,
  );
}

Map<String, dynamic> _$SpyReportDtoToJson(SpyReportDto instance) =>
    <String, dynamic>{
      'spyReportId': instance.spyReportId,
      'outCome': _$FightOutcomeEnumMap[instance.outCome],
      'spiedCountryName': instance.spiedCountryName,
      'defensePoints': instance.defensePoints,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$FightOutcomeEnumMap = {
  FightOutcome.NotPlayedYet: 0,
  FightOutcome.CurrentUser: 1,
  FightOutcome.OtherUser: 2,
};
