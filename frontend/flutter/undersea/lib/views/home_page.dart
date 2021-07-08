import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/battle_data_controller.dart';
import 'package:undersea/controllers/building_data_controller.dart';

import 'package:undersea/controllers/country_data_controller.dart';
import 'package:undersea/controllers/next_round_controller.dart';
import 'package:undersea/controllers/user_data_controller.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/expandable_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userDataController = Get.find<UserDataController>();
  final countryDataController = Get.find<CountryDataController>();
  final battleDatacontroller = Get.find<BattleDataController>();
  @override
  void initState() {
    userDataController.userInfo();
    userDataController.searchText.value = '';
    userDataController.getRankList();
    countryDataController.getCountryDetails();
    userDataController.getRankList();
    battleDatacontroller.getAllUnits();
    battleDatacontroller.getAttackableUsers();
    battleDatacontroller.getHistory();
    battleDatacontroller.getAvailableUnits();
    battleDatacontroller.getSpyingHistory();

    super.initState();
  }

  List<Widget> _drawBuildings() {
    var buildings = <Widget>[];
    var tops = <double>[120, 160, 60, 80];
    var lefts = <double>[0, 160, 100, 280];
    var buildingList =
        countryDataController.countryDetailsData.value?.buildings;
    bool hasCannon = false;
    if (countryDataController.countryDetailsData.value?.hasSonarCanon != null)
      hasCannon = countryDataController.countryDetailsData.value!.hasSonarCanon;

    if (hasCannon)
      buildings.add(UnderseaStyles.building(
          BuildingDataController.imageNameMap['Szonárágyú']!,
          top: tops.last,
          left: lefts.last));

    if (buildingList != null) {
      for (int i = 0; i < buildingList.length; i++) {
        if (buildingList[i].buildingsCount >= 1) {
          buildings.add(UnderseaStyles.building(
              BuildingDataController.imageNameMap[buildingList[i].name]!,
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
          GetBuilder<UserDataController>(builder: (controller) {
            final userInfoData = controller.userInfoData.value;
            if (userInfoData != null)
              return UnderseaStyles.leaderboardButton(
                  roundNumber: userInfoData.round,
                  placement: userInfoData.placement);
            else
              return UnderseaStyles.leaderboardButton(
                  roundNumber: 4, placement: 23);
          }),
          SizedBox(
            height: 20,
          ),
          UnderseaStyles.elevatedButton(
              text: 'Kör++',
              width: 100,
              height: 50,
              onPressed: () {
                Get.find<RoundController>().nextRound();
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
