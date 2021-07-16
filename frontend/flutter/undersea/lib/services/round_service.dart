import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/core/constants.dart';

import 'package:undersea/network/providers/next_round_provider.dart';
import 'package:undersea/network/urls.dart';

import 'battle_service.dart';
import 'building_service.dart';
import 'country_service.dart';

import 'package:signalr_core/signalr_core.dart';

import 'event_service.dart';
import 'upgrade_service.dart';
import 'user_service.dart';

class RoundService extends GetxController {
  final NextRoundProvider _roundProvider;
  late String serverUrl;

  RoundService(this._roundProvider) {
    serverUrl = Urls.SERVER_URL;
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
        .withAutomaticReconnect()
        .build();
    try {
      await connection.start();
    } catch (error) {
      log('$error');
    }

    connection.on(Constants.SOCKET, (message) {
      refreshOnNextRound();
      log('ROUND: ${message.toString()}');
    });
  }

  void refreshOnNextRound() {
    var userService = Get.find<UserService>();
    userService.userInfo();
    userService.getRankList();
    userService.reset();
    Get.find<CountryService>().getCountryDetails();
    Get.find<CountryService>().eventWindowShown = false;
    Get.find<BuildingService>().getBuildingDetails();
    Get.find<UpgradeService>().getUpgradeDetails();
    var battleController = Get.find<BattleService>();
    battleController.reset();
    battleController.getUnitTypes();
    battleController.getAllUnits();
    battleController.getSpies();
    battleController.getAvailableUnits();
    Get.find<EventService>().reset();
  }
}
