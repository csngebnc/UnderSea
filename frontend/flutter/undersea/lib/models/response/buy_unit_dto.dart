import 'package:json_annotation/json_annotation.dart';
import 'package:undersea/models/response/buy_unit_details_dto.dart';

part 'buy_unit_dto.g.dart';

@JsonSerializable()
class BuyUnitDto {
  List<BuyUnitDetailsDto> units;
  BuyUnitDto({
    required this.units,
  });

  factory BuyUnitDto.fromJson(Map<String, dynamic> json) =>
      _$BuyUnitDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BuyUnitDtoToJson(this);
}
