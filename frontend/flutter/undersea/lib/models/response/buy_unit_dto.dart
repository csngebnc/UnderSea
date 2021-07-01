import 'package:json_annotation/json_annotation.dart';

import 'attackable_user_dto.dart';

part 'buy_unit_dto.g.dart';

@JsonSerializable()
class BuyUnitDto {
  int unitId;
  int number;

  BuyUnitDto({
    required this.unitId,
    required this.number,
  });

  factory BuyUnitDto.fromJson(Map<String, dynamic> json) =>
      _$BuyUnitDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BuyUnitDtoToJson(this);
}
