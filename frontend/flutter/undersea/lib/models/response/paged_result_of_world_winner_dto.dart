import 'package:json_annotation/json_annotation.dart';
import 'package:undersea/models/response/world_winner_dto.dart';

part 'paged_result_of_world_winner_dto.g.dart';

@JsonSerializable()
class PagedResultOfWorldWinnerDto {
  List<WorldWinnerDto>? results;
  int allResultsCount;
  int pageNumber;
  int pageSize;

  PagedResultOfWorldWinnerDto(
      {required this.allResultsCount,
      required this.pageNumber,
      required this.pageSize,
      this.results});

  factory PagedResultOfWorldWinnerDto.fromJson(Map<String, dynamic> json) =>
      _$PagedResultOfWorldWinnerDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PagedResultOfWorldWinnerDtoToJson(this);
}
