// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rank_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRankDto _$UserRankDtoFromJson(Map<String, dynamic> json) {
  return UserRankDto(
    name: json['name'] as String,
    points: json['points'] as int,
  );
}

Map<String, dynamic> _$UserRankDtoToJson(UserRankDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
    };
