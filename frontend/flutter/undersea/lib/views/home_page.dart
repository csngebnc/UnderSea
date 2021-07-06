import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/building_data_controller.dart';

import 'package:undersea/controllers/country_data_controller.dart';
import 'package:undersea/controllers/next_round_controller.dart';
import 'package:undersea/controllers/user_data_controller.dart';

import 'package:undersea/models/building.dart';
import 'package:undersea/models/response/user_info_dto.dart';
import 'package:undersea/network/providers/next_round_provider.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/expandable_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final List<String> imageList; =
  /*Get.find<BuildingDataController>().*/

  //final Random rng = Random();

  final userDataController = Get.find<UserDataController>();
  final countryDataController = Get.find<CountryDataController>();

  @override
  void initState() {
    userDataController.userInfo();
    countryDataController.getCountryDetails();
    super.initState();
  }

  List<Widget> _drawBuildings() {
    var buildings = <Widget>[];
    var tops = <double>[100, 160];
    var lefts = <double>[100, 180];
    var buildingList =
        countryDataController.countryDetailsData.value?.buildings;
    if (buildingList != null) {
      for (int i = 0; i < buildingList.length; i++) {
        if (buildingList[i].buildingsCount >= 1)
          buildings.add(UnderseaStyles.building(
              BuildingDataController.imageNameMap[buildingList[i].name]!,
              top: tops[i],
              left: lefts[i]));
      }
    }

    return buildings;
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
