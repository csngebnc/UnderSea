// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_result_of_spy_report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResultOfSpyReportDto _$PagedResultOfSpyReportDtoFromJson(
    Map<String, dynamic> json) {
  return PagedResultOfSpyReportDto(
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => SpyReportDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    allResultsCount: json['allResultsCount'] as int,
    pageSize: json['pageSize'] as int,
    pageNumber: json['pageNumber'] as int,
  );
}

Map<String, dynamic> _$PagedResultOfSpyReportDtoToJson(
        PagedResultOfSpyReportDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'allResultsCount': instance.allResultsCount,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
