import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';

import 'package:undersea/models/response/buy_upgrade_dto.dart';
import 'package:undersea/models/response/upgrade_dto.dart';
import 'package:undersea/network/providers/upgrade_data_provider.dart';
import 'package:undersea/styles/style_constants.dart';

class UpgradeService extends GetxController {
  final UpgradeDataProvider _upgradeDataProvider;
  UpgradeService(this._upgradeDataProvider);

  Rx<List<UpgradeDto>> upgradeInfoData = Rx([]);

  buyUpgrade(int id) async {
    try {
      final response = await _upgradeDataProvider
          .buyUpgrade(BuyUpgradeDto(upgradeId: id).toJson());

      if (response.statusCode == 200) {
        UnderseaStyles.snackbar(
            Strings.successful_purchase.tr, Strings.new_upgrade.tr);
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

  void reset() {
    upgradeInfoData = Rx([]);
  }
}
