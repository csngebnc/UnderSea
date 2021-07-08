import 'package:json_annotation/json_annotation.dart';

import 'attackable_user_dto.dart';

part 'paged_result_of_attackable_user_dto.g.dart';

@JsonSerializable()
class PagedResultOfAttackableUserDto {
  List<AttackableUserDto>? results;
  int allResultsCount;
  int? pageNumber;
  int? pageSize;

  PagedResultOfAttackableUserDto(
      {required this.allResultsCount,
      this.pageNumber,
      this.pageSize,
      this.results});

  factory PagedResultOfAttackableUserDto.fromJson(Map<String, dynamic> json) =>
      _$PagedResultOfAttackableUserDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PagedResultOfAttackableUserDtoToJson(this);
}
