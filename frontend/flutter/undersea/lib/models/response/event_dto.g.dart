// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDto _$EventDtoFromJson(Map<String, dynamic> json) {
  return EventDto(
    id: json['id'] as int,
    eventRound: json['eventRound'] as int,
    name: json['name'] as String?,
    effects: (json['effects'] as List<dynamic>?)
        ?.map((e) => EffectDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EventDtoToJson(EventDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'eventRound': instance.eventRound,
      'effects': instance.effects,
    };
