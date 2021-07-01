// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_result_of_user_rank_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResultOfUserRankDto _$PagedResultOfUserRankDtoFromJson(
    Map<String, dynamic> json) {
  return PagedResultOfUserRankDto(
    allResultsCount: json['allResultsCount'] as int,
    pageNumber: json['pageNumber'] as int,
    pageSize: json['pageSize'] as int,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => UserRankDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PagedResultOfUserRankDtoToJson(
        PagedResultOfUserRankDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'allResultsCount': instance.allResultsCount,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
