import 'package:json_annotation/json_annotation.dart';

enum FightOutcome {
  @JsonValue(0)
  NotPlayedYet,
  @JsonValue(1)
  CurrentUser,
  @JsonValue(2)
  OtherUser,
}
