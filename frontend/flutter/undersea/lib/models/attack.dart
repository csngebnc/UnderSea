class AttackDetails {
  String targetedCity;
  Map<String, int> soldiers;
  String winnerPlayerName;

  AttackDetails(
      {required this.targetedCity,
      required this.soldiers,
      required this.winnerPlayerName});
}
