import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/controllers/upgrades_controller.dart';
import 'package:undersea/controllers/user_data_controller.dart';
import 'package:undersea/network/providers/next_round_provider.dart';

import 'battle_data_controller.dart';
import 'building_data_controller.dart';
import 'country_data_controller.dart';
import 'package:signalr_flutter/signalr_flutter.dart';

class RoundController extends GetxController {
  final NextRoundProvider _roundProvider;
  late String serverUrl;
  late SignalR signalR;
  RoundController(this._roundProvider) {
    serverUrl = _roundProvider.httpClient.baseUrl! + 'roundHub';
  }

  @override
  void onInit() {
    super.onInit();
  }

  void nextRound() async {
    try {
      log((await signalR.isConnected).toString());
      final response = await _roundProvider.nextRound();
      if (response.statusCode == 200) {
        refreshOnNextRound();
      }
    } catch (error) {
      log('$error');
    }
  }

  Future<void> initPlatformState() async {
    signalR = SignalR(
      serverUrl,
      "SendMessage",
      hubMethods: ["SendMessage"],
      //statusChangeCallback: _onStatusChange,
      hubCallback: (methodName, message) => log('signalR working'),
    );

    signalR.connect();
  }

  void refreshOnNextRound() {
    Get.find<UserDataController>().userInfo();
    Get.find<CountryDataController>().getCountryDetails();
    Get.find<BuildingDataController>().getBuildingDetails();
    Get.find<UpgradesController>().getUpgradeDetails();
    Get.find<BattleDataController>().getUnitTypes();
    Get.find<BattleDataController>().getAllUnits();
    Get.find<BattleDataController>().getSpies();
  }
}
