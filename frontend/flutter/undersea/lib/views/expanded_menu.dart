import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/battle_data_controller.dart';
import 'package:undersea/controllers/building_data_controller.dart';

import 'package:undersea/controllers/country_data_controller.dart';

import 'package:undersea/models/response/battle_unit_dto.dart';
import 'package:undersea/models/response/building_info_dto.dart';
import 'package:undersea/models/response/country_details_dto.dart';
import 'package:undersea/styles/style_constants.dart';

class ExpandedMenu extends StatelessWidget {
  ExpandedMenu();

  Widget _enumerateSoldiers(List<BattleUnitDto> units) {
    final allUnits = Get.find<BattleDataController>().allUnitsInfo.value;
    final spiesCount = Get.find<BattleDataController>().spiesInfo.value?.count;

    List<Widget> list = <Widget>[];
    units.forEach((element) {
      var isSpy = element.name == 'Felfedező';
      var actualSoldierMax = allUnits
          .firstWhere(
            (a) => a.id == element.id,
            orElse: () =>
                BattleUnitDto(id: 0, name: 'name', count: 0, level: 1),
          )
          .count;
      list.add(UnderseaStyles.militaryIcon(
          BattleDataController.imageNameMap[element.name] ?? 'shark',
          element.count,
          isSpy ? spiesCount! : actualSoldierMax));
    });
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }

  List<Widget> _enumerateBuildings(List<BuildingInfoDto> buildingDtos) {
    List<Widget> buildings = <Widget>[];
    buildingDtos.forEach((element) {
      buildings.add(UnderseaStyles.buildingIcon(
          BuildingDataController.imageNameMap[element.name] ?? 'zatonyvar',
          element.buildingsCount));
    });
    return buildings;
  }

  List<Widget> _enumerateResources(CountryDetailsDto? countryDetails) {
    List<Widget> resources = <Widget>[];
    countryDetails!.materials!.forEach((element) {
      resources.add(UnderseaStyles.resourceIcon(
          UnderseaStyles.resourceNamesMap[element.name] ?? 'stone',
          element.amount,
          element.production));
    });
    return resources;
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
              ..._enumerateResources(countryData),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [..._enumerateBuildings(countryData.buildings!)],
          )
        ]);
      } else {
        return Expanded(child: Container());
      }
    });
  }
}
