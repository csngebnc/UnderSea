import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/models/response/battle_unit_dto.dart';
import 'package:undersea/models/response/building_info_dto.dart';
import 'package:undersea/models/response/country_details_dto.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/services/building_service.dart';
import 'package:undersea/services/country_service.dart';
import 'package:undersea/styles/style_constants.dart';

class ExpandedMenu extends StatelessWidget {
  ExpandedMenu();

  List<Widget> _enumerateSoldiers(List<BattleUnitDto> units) {
    final allUnits = Get.find<BattleService>().allUnitsInfo.value;
    final spiesCount = Get.find<BattleService>().spiesInfo.value?.count;

    return units
        .map((e) => UnderseaStyles.militaryIcon(
            BattleService.imageNameMap[e.name] ?? 'shark',
            e.count,
            e.name == 'Felfedező'
                ? (spiesCount ?? 0)
                : allUnits
                    .where((a) => a.id == e.id)
                    .fold(0, (prev, cur) => prev += cur.count)))
        .toList();
  }

  List<Widget> _enumerateBuildings(List<BuildingInfoDto> buildingDtos) {
    return buildingDtos
        .map((e) => UnderseaStyles.buildingIcon(
            BuildingService.imageNameMap[e.name] ?? 'zatonyvar',
            e.buildingsCount))
        .toList();
  }

  List<Widget> _enumerateResources(CountryDetailsDto? countryDetails) {
    return countryDetails?.materials
            ?.map((e) => UnderseaStyles.resourceIcon(
                UnderseaStyles.resourceNamesMap[e.name] ?? 'stone',
                e.amount,
                e.production))
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CountryService>(builder: (controller) {
      final countryData = controller.countryDetailsData.value;
      if (controller.countryDataLoading.value) {
        return Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Center(
              child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                  height: 100,
                  width: 100)),
        );
      }
      if (countryData != null) {
        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ..._enumerateSoldiers(countryData.units!),
            ],
          ),
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
