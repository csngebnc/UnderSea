import 'package:json_annotation/json_annotation.dart';
import 'package:undersea/models/response/logged_attack_dto.dart';

part 'paged_result_of_logged_attack_dto.g.dart';

@JsonSerializable()
class PagedResultOfLoggedAttackDto {
  List<LoggedAttackDto>? results;
  int allResultsCount;
  int pageNumber;
  int pageSize;

  PagedResultOfLoggedAttackDto(
      {required this.allResultsCount,
      required this.pageNumber,
      required this.pageSize,
      this.results});

  factory PagedResultOfLoggedAttackDto.fromJson(Map<String, dynamic> json) =>
      _$PagedResultOfLoggedAttackDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PagedResultOfLoggedAttackDtoToJson(this);
}
