import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/services/building_service.dart';
import 'package:undersea/services/country_service.dart';
import 'package:undersea/services/round_service.dart';
import 'package:undersea/services/user_service.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/expandable_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userService = Get.find<UserService>();
  final countryService = Get.find<CountryService>();
  final battleService = Get.find<BattleService>();
  var rng = Random();
  @override
  void initState() {
    userService.userInfo();
    userService.getWinners();
    userService.searchText.value = '';
    userService.getRankList();
    countryService.getCountryDetails();
    userService.getRankList();
    battleService.getAllUnits();
    battleService.getAttackableUsers();
    battleService.getHistory();
    battleService.getAvailableUnits();
    battleService.getSpyingHistory();

    super.initState();
  }

  List<Widget> _drawBuildings() {
    var buildings = <Widget>[];
    var tops = <double>[120, 160, 60, 80];
    var lefts = <double>[0, 160, 100, 280];
    var buildingList = countryService.countryDetailsData.value?.buildings;
    bool hasCannon = false;
    if (countryService.countryDetailsData.value?.hasSonarCanon != null) {
      hasCannon = countryService.countryDetailsData.value!.hasSonarCanon;
    }

    if (hasCannon) {
      buildings.add(UnderseaStyles.building(
          BuildingService.imageNameMap['Szonárágyú']!,
          top: tops.last,
          left: lefts.last));
    }

    if (buildingList != null) {
      for (int i = 0; i < buildingList.length; i++) {
        if (buildingList[i].buildingsCount >= 1) {
          buildings.add(UnderseaStyles.building(
              BuildingService.imageNameMap[buildingList[i].name]!,
              top: tops[i],
              left: lefts[i]));
        }
      }
    }

    return buildings.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background/main bg4@3x.png'),
              fit: BoxFit.cover),
        ),
        child: Column(children: [
          SizedBox(height: 10),
          GetBuilder<UserService>(builder: (controller) {
            final userInfoData = controller.userInfoData.value;

            if (userInfoData != null) {
              return UnderseaStyles.leaderboardButton(
                  roundNumber: userInfoData.round,
                  placement: userInfoData.placement);
            } else if (controller.userInfoLoading.value) {
              return UnderseaStyles.leaderboardButton();
            } else {
              return CircularProgressIndicator();
            }
          }),
          SizedBox(
            height: 20,
          ),
          UnderseaStyles.elevatedButton(
              text: 'Kör++',
              width: 100,
              height: 50,
              onPressed: () {
                Get.find<RoundService>().nextRound();
              }),
          Expanded(
              child: Stack(
            fit: StackFit.expand,
            children: [..._drawBuildings()],
          )),
          ExpandableMenu(),
        ]));
  }
}
