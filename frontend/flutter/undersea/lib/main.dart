import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/network/providers/country_data_provider.dart';
import 'package:undersea/network/providers/event_provider.dart';
import 'package:undersea/network/providers/next_round_provider.dart';
import 'package:undersea/network/providers/upgrade_data_provider.dart';
import 'package:undersea/routes/app_router.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/services/building_service.dart';
import 'package:undersea/services/country_service.dart';
import 'package:undersea/services/event_service.dart';
import 'package:undersea/services/round_service.dart';
import 'package:undersea/services/upgrade_service.dart';
import 'package:undersea/services/user_service.dart';
import 'package:undersea/modules/login/login_screen.dart';

import 'core/lang/app_translations.dart';
import 'core/lang/strings.dart';
import 'network/providers/battle_data_provider.dart';
import 'network/providers/building_data_provider.dart';
import 'network/providers/user_data_provider.dart';

void main() async {
  await initServices();

  runApp(MyApp());
}

Future<void> initServices() async {
  await GetStorage.init();
  Get.put(NextRoundProvider());

  Get.put(RoundService(Get.find()));
  var roundController = Get.find<RoundService>();
  Get.put(UserDataProvider());
  Get.put(UserService(Get.find()));
  Get.put(CountryDataProvider());
  Get.put(CountryService(Get.find()));
  Get.put(BuildingDataProvider());
  Get.put(BuildingService(Get.find()));

  Get.put(UpgradeDataProvider());
  Get.put(UpgradeService(Get.find()));
  Get.put(BattleDataProvider());
  Get.put(BattleService(Get.find()));
  Get.put(EventProvider());
  Get.put(EventService(Get.find()));

  roundController.initPlatformState();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final String _title = Strings.undersea.tr;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      locale: AppTranslations.locale,
      fallbackLocale: AppTranslations.fallbackLocale,
      translations: AppTranslations(),
      debugShowCheckedModeBanner: false,
      title: _title,
      home: LoginScreen(),
      getPages: AppRouter.routes,
      initialRoute: AppRouter.INITIAL,
    );
  }
}
