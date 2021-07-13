// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_winner_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldWinnerDto _$WorldWinnerDtoFromJson(Map<String, dynamic> json) {
  return WorldWinnerDto(
    id: json['id'] as int,
    points: json['points'] as int,
    date: DateTime.parse(json['date'] as String),
    worldRound: json['worldRound'] as int,
    userName: json['userName'] as String?,
    countryName: json['countryName'] as String?,
  );
}

Map<String, dynamic> _$WorldWinnerDtoToJson(WorldWinnerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'countryName': instance.countryName,
      'worldRound': instance.worldRound,
      'date': instance.date.toIso8601String(),
      'points': instance.points,
    };
