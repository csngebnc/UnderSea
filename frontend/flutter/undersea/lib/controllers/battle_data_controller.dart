import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/models/response/buy_upgrade_dto.dart';
import 'package:undersea/models/response/upgrade_dto.dart';
import 'package:undersea/models/upgrade.dart';
import 'package:undersea/network/providers/battle_data_provider.dart';
import 'package:undersea/network/providers/upgrade_data_provider.dart';

class BattleDataController extends GetxController {
  final BattleDataProvider _battleDataProvider;
  BattleDataController(this._battleDataProvider);

  /* Rx<List<UpgradeDto>> battle = Rx([]);

  buyUpgrade(int id) async {
    try {
      final response = await _battleDataProvider
          .buyUpgrade(BuyUpgradeDto(upgradeId: id).toJson());

      if (response.statusCode == 200) {
        Get.snackbar('Sikeres vásárlás!', '');
        getUpgradeDetails();
      }
    } catch (error) {
      log('$error');
    }
  }

  getUpgradeDetails() async {
    try {
      final response = await _upgradeDataProvider.getUpgradeDetails();
      if (response.statusCode == 200) {
        upgradeInfoData = Rx(response.body!);
        update();
      }
    } catch (error) {
      log('$error');
    }
  }*/

}
