import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/controllers/battle_data_controller.dart';
import 'package:undersea/controllers/country_data_controller.dart';
import 'package:undersea/controllers/navbar_controller.dart';
import 'package:undersea/controllers/next_round_controller.dart';

import 'package:undersea/lang/app_translations.dart';
import 'package:undersea/network/providers/country_data_provider.dart';
import 'package:undersea/network/providers/next_round_provider.dart';
import 'package:undersea/network/providers/upgrade_data_provider.dart';

import 'package:undersea/views/login.dart';
import 'controllers/building_data_controller.dart';
import 'controllers/upgrades_controller.dart';

import 'controllers/user_data_controller.dart';
import 'lang/strings.dart';
import 'network/providers/battle_data_provider.dart';
import 'network/providers/building_data_provider.dart';
import 'network/providers/user_data_provider.dart';

void main() async {
  await initServices();

  runApp(MyApp());
}

Future<void> initServices() async {
  await GetStorage.init();

  Get.put(BottomNavBarController());
  Get.put(UserDataProvider());
  Get.put(UserDataController(Get.find()));
  Get.put(CountryDataProvider());
  Get.put(CountryDataController(Get.find()));
  Get.put(BuildingDataProvider());
  Get.put(BuildingDataController(Get.find()));
  Get.put(NextRoundProvider());
  Get.put(RoundController(Get.find()));
  Get.put(UpgradeDataProvider());
  Get.put(UpgradesController(Get.find()));
  Get.put(BattleDataProvider());
  Get.put(BattleDataController(Get.find()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static String _title = Strings.undersea.tr;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: AppTranslations.locale,
      fallbackLocale: AppTranslations.fallbackLocale,
      translations: AppTranslations(),
      title: _title,
      home: LoginPage(),
    );
  }
}
