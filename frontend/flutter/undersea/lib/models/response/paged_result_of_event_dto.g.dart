// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_result_of_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResultOfEventDto _$PagedResultOfEventDtoFromJson(
    Map<String, dynamic> json) {
  return PagedResultOfEventDto(
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => EventDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    allResultsCount: json['allResultsCount'] as int,
    pageSize: json['pageSize'] as int,
    pageNumber: json['pageNumber'] as int,
  );
}

Map<String, dynamic> _$PagedResultOfEventDtoToJson(
        PagedResultOfEventDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'allResultsCount': instance.allResultsCount,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
