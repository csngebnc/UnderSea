import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/controllers/buildings_controller.dart';
import 'package:undersea/controllers/login_controller.dart';
import 'package:undersea/controllers/navbar_controller.dart';
import 'package:undersea/controllers/player_controller.dart';
import 'package:undersea/controllers/soldiers_controller.dart';
import 'package:undersea/lang/app_translations.dart';
import 'package:undersea/views/login.dart';
import 'controllers/upgrades_controller.dart';

import 'lang/strings.dart';
import 'network/providers/login_provider.dart';

void main() async {
  await initServices();

  runApp(MyApp());
}

Future<void> initServices() async {
  Get.put(PlayerController());
  Get.put(BottomNavBarController());
  Get.put(SoldiersController());
  Get.put(UpgradesController());
  Get.put(BuildingsController());
  Get.put(LoginProvider());
  Get.put(LoginController(Get.find()));
  await GetStorage.init();
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
