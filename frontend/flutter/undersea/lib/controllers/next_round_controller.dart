import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/controllers/upgrades_controller.dart';
import 'package:undersea/controllers/user_data_controller.dart';
import 'package:undersea/network/providers/next_round_provider.dart';

import 'battle_data_controller.dart';
import 'building_data_controller.dart';
import 'country_data_controller.dart';

import 'package:signalr_core/signalr_core.dart';

class RoundController extends GetxController {
  final NextRoundProvider _roundProvider;
  late String serverUrl;

  RoundController(this._roundProvider) {
    serverUrl = _roundProvider.httpClient.baseUrl! + 'roundHub';
  }

  void nextRound() async {
    try {
      final response = await _roundProvider.nextRound();
      if (response.statusCode == 200) {
        log('Next round pressed');
      }
    } catch (error) {
      log('$error');
    }
  }

  Future<void> initPlatformState() async {
    final connection = HubConnectionBuilder()
        .withUrl(
            serverUrl,
            HttpConnectionOptions(
              logging: (level, message) => print(message),
            ))
        .build();

    await connection.start();

    connection.on('SendMessage', (message) {
      refreshOnNextRound();
      log(message.toString());
    });
  }

  void refreshOnNextRound() {
    Get.find<UserDataController>().userInfo();
    Get.find<CountryDataController>().getCountryDetails();
    Get.find<BuildingDataController>().getBuildingDetails();
    Get.find<UpgradesController>().getUpgradeDetails();
    var battleController = Get.find<BattleDataController>();
    battleController.reset();
    battleController.getUnitTypes();
    battleController.getAllUnits();
    battleController.getSpies();
    battleController.getAttackableUsers();
    battleController.getHistory();
    battleController.getAvailableUnits();
    battleController.getSpyingHistory();
  }
}
