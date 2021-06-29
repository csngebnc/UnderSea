import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/player_controller.dart';
import 'package:undersea/controllers/soldiers_controller.dart';
import 'package:undersea/models/soldier.dart';
import 'package:undersea/styles/style_constants.dart';

class ExpandedMenu extends StatelessWidget {
  ExpandedMenu();
  final resourceData = Get.find<PlayerController>().playerData.value;
  final List<Soldier> militaryData = Get.find<SoldiersController>().soldierList;

  Widget _enumerateSoldiers() {
    List<Widget> list = <Widget>[];
    militaryData.forEach((element) {
      list.add(UnderseaStyles.militaryIcon(
          element.iconName, element.available, element.totalAmount));
    });
    return new Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _enumerateSoldiers(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnderseaStyles.resourceIcon(
              "pearl", resourceData.pearlAmount, resourceData.pearlPerRound),
          UnderseaStyles.resourceIcon(
              "coral", resourceData.coralAmount, resourceData.coralPerRound),
          UnderseaStyles.buildingIcon("zatonyvar@3x", 1),
          UnderseaStyles.buildingIcon("aramlasiranyito@3x", 0),
        ],
      )
    ]);
  }
}
