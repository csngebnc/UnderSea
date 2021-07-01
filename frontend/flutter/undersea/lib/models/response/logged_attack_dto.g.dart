// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_attack_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggedAttackDto _$LoggedAttackDtoFromJson(Map<String, dynamic> json) {
  return LoggedAttackDto(
    attackedCountryName: json['attackedCountryName'] as String?,
    outcome: _$enumDecode(_$FightOutcomeEnumMap, json['outcome']),
    units: (json['units'] as List<dynamic>?)
        ?.map((e) => BattleUnitDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LoggedAttackDtoToJson(LoggedAttackDto instance) =>
    <String, dynamic>{
      'units': instance.units,
      'attackedCountryName': instance.attackedCountryName,
      'outcome': _$FightOutcomeEnumMap[instance.outcome],
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
  FightOutcome.NotPlayedYet: 'NotPlayedYet',
  FightOutcome.CurrentUser: 'CurrentUser',
  FightOutcome.OtherUser: 'OtherUser',
};
