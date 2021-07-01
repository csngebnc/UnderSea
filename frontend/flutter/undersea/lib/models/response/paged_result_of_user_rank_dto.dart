import 'package:json_annotation/json_annotation.dart';
import 'package:undersea/models/response/user_rank_dto.dart';

part 'paged_result_of_user_rank_dto.g.dart';

@JsonSerializable()
class PagedResultOfUserRankDto {
  List<UserRankDto>? results;
  int allResultsCount;
  int pageNumber;
  int pageSize;

  PagedResultOfUserRankDto(
      {required this.allResultsCount,
      required this.pageNumber,
      required this.pageSize,
      this.results});

  factory PagedResultOfUserRankDto.fromJson(Map<String, dynamic> json) =>
      _$PagedResultOfUserRankDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PagedResultOfUserRankDtoToJson(this);
}
