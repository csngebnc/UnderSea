import 'package:json_annotation/json_annotation.dart';

import 'package:undersea/models/response/spy_report_dto.dart';

part 'paged_result_of_spy_report_dto.g.dart';

@JsonSerializable()
class PagedResultOfSpyReportDto {
  List<SpyReportDto>? results;
  int allResultsCount;
  int pageNumber;
  int pageSize;

  PagedResultOfSpyReportDto(
      {this.results,
      required this.allResultsCount,
      required this.pageSize,
      required this.pageNumber});

  factory PagedResultOfSpyReportDto.fromJson(Map<String, dynamic> json) =>
      _$PagedResultOfSpyReportDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PagedResultOfSpyReportDtoToJson(this);
}
