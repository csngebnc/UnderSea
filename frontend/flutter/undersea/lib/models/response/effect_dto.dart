import 'package:json_annotation/json_annotation.dart';

part 'effect_dto.g.dart';

@JsonSerializable()
class EffectDto {
  int id;
  String name;
  EffectDto({
    required this.id,
    required this.name,
  });

  factory EffectDto.fromJson(Map<String, dynamic> json) =>
      _$EffectDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$EffectDtoToJson(this);
}
