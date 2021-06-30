import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/buildings_controller.dart';
import 'package:undersea/models/building.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/expandable_menu.dart';

class HomePage extends StatelessWidget {
  final List<Building> buildingList =
      Get.find<BuildingsController>().buildingList;
  final Random rng = Random();

  List<Widget> _drawBuildings() {
    var buildings = <Widget>[];
    var tops = <double>[100, 160];
    var lefts = <double>[100, 180];
    for (int i = 0; i < buildingList.length; i++) {
      if (buildingList[i].currentAmount >= 1)
        buildings.add(UnderseaStyles.building(buildingList[i].imageName,
            top: tops[i], left: lefts[i]));
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
          UnderseaStyles.leaderboardButton(roundNumber: 4, placement: 23),
          Expanded(
              child: Stack(
            fit: StackFit.expand,
            children: [..._drawBuildings()],
          )),
          ExpandableMenu(),
        ]));
  }
}
