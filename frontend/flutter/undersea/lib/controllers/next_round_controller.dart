import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/controllers/upgrades_controller.dart';
import 'package:undersea/controllers/user_data_controller.dart';
import 'package:undersea/network/providers/next_round_provider.dart';

import 'battle_data_controller.dart';
import 'building_data_controller.dart';
import 'country_data_controller.dart';

class RoundController extends GetxController {
  final NextRoundProvider _roundProvider;

  RoundController(this._roundProvider);

  void nextRound() async {
    try {
      final response = await _roundProvider.nextRound();
      if (response.statusCode == 200) {
        Get.find<UserDataController>().userInfo();
        Get.find<CountryDataController>().getCountryDetails();
        Get.find<BuildingDataController>().getBuildingDetails();
        Get.find<UpgradesController>().getUpgradeDetails();
        Get.find<BattleDataController>().getUnitTypes();
        Get.find<BattleDataController>().getAllUnits();
        Get.find<BattleDataController>().getSpies();
      }
    } catch (error) {
      log('$error');
    }
  }
}
