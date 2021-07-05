import 'package:json_annotation/json_annotation.dart';

import 'effect_dto.dart';

part 'upgrade_dto.g.dart';

@JsonSerializable()
class UpgradeDto {
  int id;
  String name;
  bool doesExist;
  bool isUnderConstruction;
  int remainingTime;
  String? imageUrl;
  List<EffectDto>? effects;

  UpgradeDto(
      {this.effects,
      required this.id,
      required this.doesExist,
      required this.isUnderConstruction,
      required this.name,
      required this.remainingTime,
      this.imageUrl});

  factory UpgradeDto.fromJson(Map<String, dynamic> json) =>
      _$UpgradeDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UpgradeDtoToJson(this);
}
