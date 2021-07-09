import 'package:json_annotation/json_annotation.dart';

part 'buy_unit_details_dto.g.dart';

@JsonSerializable()
class BuyUnitDetailsDto {
  int unitId;
  int count;

  BuyUnitDetailsDto({
    required this.unitId,
    required this.count,
  });

  factory BuyUnitDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$BuyUnitDetailsDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BuyUnitDetailsDtoToJson(this);
}
