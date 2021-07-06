// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_result_of_logged_attack_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResultOfLoggedAttackDto _$PagedResultOfLoggedAttackDtoFromJson(
    Map<String, dynamic> json) {
  return PagedResultOfLoggedAttackDto(
    allResultsCount: json['allResultsCount'] as int,
    pageNumber: json['pageNumber'] as int,
    pageSize: json['pageSize'] as int,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => LoggedAttackDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PagedResultOfLoggedAttackDtoToJson(
        PagedResultOfLoggedAttackDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'allResultsCount': instance.allResultsCount,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
