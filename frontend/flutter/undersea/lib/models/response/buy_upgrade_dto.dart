import 'package:json_annotation/json_annotation.dart';

part 'buy_upgrade_dto.g.dart';

@JsonSerializable()
class BuyUpgradeDto {
  int upgradeId;

  BuyUpgradeDto({
    required this.upgradeId,
  });

  factory BuyUpgradeDto.fromJson(Map<String, dynamic> json) =>
      _$BuyUpgradeDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BuyUpgradeDtoToJson(this);
}
