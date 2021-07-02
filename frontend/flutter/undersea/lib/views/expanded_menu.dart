import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/buildings_controller.dart';
import 'package:undersea/controllers/country_data_controller.dart';
import 'package:undersea/controllers/player_controller.dart';
import 'package:undersea/controllers/soldiers_controller.dart';
import 'package:undersea/models/building.dart';
import 'package:undersea/models/response/battle_unit_dto.dart';
import 'package:undersea/models/response/building_info_dto.dart';
import 'package:undersea/models/response/country_details_dto.dart';
import 'package:undersea/models/response/unit_dto.dart';
import 'package:undersea/models/soldier.dart';
import 'package:undersea/styles/style_constants.dart';

class ExpandedMenu extends StatelessWidget {
  ExpandedMenu();
  final resourceData = Get.find<PlayerController>().playerData.value;
  final List<Soldier> militaryList = Get.find<SoldiersController>().soldierList;
  final List<Building> buildingList =
      Get.find<BuildingsController>().buildingList;

  Widget _enumerateSoldiers(List<BattleUnitDto> units) {
    List<Widget> list = <Widget>[];
    units.forEach((element) {
      list.add(UnderseaStyles.militaryIcon(
          'seahorse', element.count, element.count));
    });
    return new Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }

  List<Widget> _enumerateBuildings(List<BuildingInfoDto> buildingDtos) {
    List<Widget> buildings = <Widget>[];
    buildingDtos.forEach((element) {
      buildings.add(
          UnderseaStyles.buildingIcon('zatonyvar', element.buildingsCount));
    });
    return buildings;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CountryDataController>(builder: (controller) {
      final countryData = controller.countryDetailsData.value;
      if (countryData != null) {
        return Column(children: [
          _enumerateSoldiers(countryData.units!),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UnderseaStyles.resourceIcon("pearl", countryData.pearl,
                  countryData.currentPearlProduction),
              UnderseaStyles.resourceIcon("coral", countryData.coral,
                  countryData.currentCoralProduction),
              ..._enumerateBuildings(countryData.buildings!)
              /*UnderseaStyles.buildingIcon("zatonyvar@3x", 1),
          UnderseaStyles.buildingIcon("aramlasiranyito@3x", 0),*/
            ],
          )
        ]);
      } else
        return Expanded(child: Container());
    });
  }
}
