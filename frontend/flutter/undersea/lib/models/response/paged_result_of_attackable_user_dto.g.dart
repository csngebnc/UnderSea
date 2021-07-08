// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_result_of_attackable_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResultOfAttackableUserDto _$PagedResultOfAttackableUserDtoFromJson(
    Map<String, dynamic> json) {
  return PagedResultOfAttackableUserDto(
    allResultsCount: json['allResultsCount'] as int,
    pageNumber: json['pageNumber'] as int?,
    pageSize: json['pageSize'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => AttackableUserDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PagedResultOfAttackableUserDtoToJson(
        PagedResultOfAttackableUserDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'allResultsCount': instance.allResultsCount,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
