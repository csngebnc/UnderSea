import 'package:get/get.dart';

class PlayerController extends GetxController {
  Rx<PlayerData> playerData = PlayerData(
          coralAmount: 230,
          pearlAmount: 230,
          pearlPerRound: 12,
          coralPerRound: 12,
          placement: 23,
          numberOfRounds: 4,
          cityName: 'Óceánia',
          playerName: 'jakabjatekos')
      .obs;
}

class PlayerData {
  int coralAmount = 230;
  int pearlAmount = 230;
  int pearlPerRound = 12;
  int coralPerRound = 12;
  int placement = 23;
  int numberOfRounds = 4;
  String cityName = 'Óceánia';
  String playerName = 'jakabjatekos';

  PlayerData(
      {required this.cityName,
      required this.playerName,
      required this.numberOfRounds,
      required this.placement,
      required this.coralPerRound,
      required this.coralAmount,
      required this.pearlPerRound,
      required this.pearlAmount});
}
