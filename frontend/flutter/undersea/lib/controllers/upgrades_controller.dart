import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/models/response/buy_upgrade_dto.dart';
import 'package:undersea/models/response/upgrade_dto.dart';
import 'package:undersea/models/upgrade.dart';
import 'package:undersea/network/providers/upgrade_data_provider.dart';

class UpgradesController extends GetxController {
  final UpgradeDataProvider _upgradeDataProvider;
  UpgradesController(this._upgradeDataProvider);

  Rx<List<UpgradeDto>> upgradeInfoData = Rx([]);

  buyUpgrade(int id) async {
    try {
      final response = await _upgradeDataProvider
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
  }

  var imageNameMap = {
    'Iszaptraktor': 'iszaptraktor',
    'Iszapkombájn': 'iszapkombajn',
    'Korallfal': 'korallfal',
    'Szonárágyú': 'szonaragyu',
    'Vízalatti harcművészetek': 'vizicsillag',
    'Alkímia': 'alkimia',
  };
  /*var upgradeList = <Upgrade>[
    Upgrade(
      availableIn: 3,
      name: "Iszaptraktor",
      imageName: "iszaptraktor",
      effect: "növeli a krumpli termesztést 10%-kal",
      isAvailable: true,
      isInProgress: false,
    ),
    Upgrade(
      availableIn: 3,
      name: "Iszapkombájn",
      imageName: "iszapkombajn",
      effect: "növeli a krumpli termesztést 15%-kal",
      isAvailable: true,
      isInProgress: false,
    ),
    Upgrade(
      availableIn: 5,
      name: "Korallfal",
      imageName: "korallfal",
      effect: "növeli a védelmi pontokat 20%-kal",
      isAvailable: false,
      isInProgress: false,
    ),
    Upgrade(
      availableIn: 3,
      name: "Szonárágyú",
      imageName: "szonaragyu",
      effect: "növeli a támadópontokat 20%-kal",
      isAvailable: false,
      isInProgress: false,
    ),
    Upgrade(
      availableIn: 3,
      name: "Vízalatti harcművészetek",
      imageName: "vizicsillag",
      effect: "növeli a védelmi és támadóerőt 10%-kal",
      isAvailable: false,
      isInProgress: false,
    ),
    Upgrade(
      availableIn: 3,
      name: "Alkímia",
      imageName: "alkimia",
      effect: "növeli a beszedett adót 30%-kal",
      isAvailable: false,
      isInProgress: false,
    ),
  ].obs;*/
}
