import 'package:json_annotation/json_annotation.dart';

import 'event_dto.dart';

part 'paged_result_of_event_dto.g.dart';

@JsonSerializable()
class PagedResultOfEventDto {
  List<EventDto>? results;
  int allResultsCount;
  int pageNumber;
  int pageSize;

  PagedResultOfEventDto(
      {this.results,
      required this.allResultsCount,
      required this.pageSize,
      required this.pageNumber});

  factory PagedResultOfEventDto.fromJson(Map<String, dynamic> json) =>
      _$PagedResultOfEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PagedResultOfEventDtoToJson(this);
}
