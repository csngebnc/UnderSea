// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_result_of_world_winner_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResultOfWorldWinnerDto _$PagedResultOfWorldWinnerDtoFromJson(
    Map<String, dynamic> json) {
  return PagedResultOfWorldWinnerDto(
    allResultsCount: json['allResultsCount'] as int,
    pageNumber: json['pageNumber'] as int,
    pageSize: json['pageSize'] as int,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => WorldWinnerDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PagedResultOfWorldWinnerDtoToJson(
        PagedResultOfWorldWinnerDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'allResultsCount': instance.allResultsCount,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
