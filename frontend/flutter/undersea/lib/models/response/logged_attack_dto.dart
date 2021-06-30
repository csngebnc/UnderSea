import 'package:json_annotation/json_annotation.dart';
import 'package:undersea/models/response/battle_unit_dto.dart';

import '../fight_outcome.dart';

part 'logged_attack_dto.g.dart';

@JsonSerializable()
class LoggedAttackDto {
  List<BattleUnitDto>? units;
  String? attackedCountryName;
  FightOutcome outcome;

  LoggedAttackDto({
    this.attackedCountryName,
    required this.outcome,
    this.units,
  });

  factory LoggedAttackDto.fromJson(Map<String, dynamic> json) =>
      _$LoggedAttackDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LoggedAttackDtoToJson(this);
}
