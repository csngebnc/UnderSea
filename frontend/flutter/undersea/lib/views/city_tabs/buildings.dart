import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/models/response/building_details_dto.dart';
import 'package:undersea/models/response/material_dto.dart';
import 'package:undersea/services/building_service.dart';
import 'package:undersea/services/country_service.dart';
import 'package:undersea/styles/style_constants.dart';

class Buildings extends StatefulWidget {
  @override
  _BuildingsTabState createState() => _BuildingsTabState();
}

class _BuildingsTabState extends State<Buildings> {
  BuildingService controller = Get.find();
  late Rx<List<BuildingDetailsDto>> buildingList;

  int? _selectedIndex;

  @override
  void initState() {
    buildingList = controller.buildingInfoData;
    super.initState();
  }

  CountryService playerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return UnderseaStyles.tabSkeleton(
        onButtonPressed: () {
          controller.buildingInfoData.value[_selectedIndex!].underConstruction =
              true;

          controller.buyBuilding(buildingList.value[_selectedIndex!].id);
          setState(() {
            _selectedIndex = null;
          });
        },
        isDisabled: !_canStartBuilding(),
        list: ListView.builder(
            itemCount: buildingList.value.length + 2,
            itemBuilder: (BuildContext context, int i) {
              return GetBuilder<BuildingService>(builder: (controller) {
                if (i == 0) {
                  return UnderseaStyles.infoPanel(
                      Strings.buildings_manual_title.tr,
                      Strings.buildings_manual_hint.tr);
                }
                if (i > buildingList.value.length) {
                  return controller.buildingInfoData.value.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: const SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator()),
                          ),
                        )
                      : SizedBox(height: 100);
                }

                final buildingListValue = controller.buildingInfoData.value;
                return _buildRow(i, buildingListValue);
              });
            }));
  }

  bool _canStartBuilding() {
    if (_selectedIndex == null) return false;
    if (buildingList.value.any((element) => element.underConstruction)) {
      return false;
    }
    var materials = buildingList.value[_selectedIndex!].requiredMaterials ??
        <MaterialDto>[];
    for (int i = 0; i < materials.length; i++) {
      var cost = materials[i];
      var available = playerController.countryDetailsData.value!.materials
          ?.firstWhere((element) => element.id == cost.id);
      if (cost.amount > available!.amount) return false;
    }

    return true;
  }

  List<Widget> _listEffects(BuildingDetailsDto building) =>
      building.effects
          ?.map((e) => Text(e.name ?? 'effect', style: UnderseaStyles.listBold))
          .toList() ??
      [];

  List<Widget> _listResourceCost(BuildingDetailsDto building) {
    return building.requiredMaterials
            ?.map((e) => Text('${e.amount} ${e.name}  ',
                style: UnderseaStyles.listRegular))
            .toList() ??
        [];
  }

  Widget _buildRow(int index, List<BuildingDetailsDto> list) {
    var actualBuilding = list[index - 1];
    return ListTile(
        onTap: () {
          setState(() {
            if ((index - 1) != _selectedIndex) {
              _selectedIndex = index - 1;
            } else {
              _selectedIndex = null;
            }
          });
        },
        title: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: UnderseaStyles.buildingImage(
                                  BuildingService
                                          .imageNameMap[actualBuilding.name] ??
                                      '' + '@3x'),
                            ),
                            Text(actualBuilding.name ?? '',
                                style: UnderseaStyles.listBold),
                            ..._listEffects(actualBuilding),
                            Text(
                                actualBuilding.count.toString() +
                                    Strings.amount.tr,
                                style: UnderseaStyles.listRegular),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [..._listResourceCost(actualBuilding)],
                            )
                          ],
                        ),
                      ),
                      actualBuilding.underConstruction
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                Strings.under_construction.tr,
                                style: TextStyle(
                                    color: UnderseaStyles.underseaLogoColor,
                                    fontSize: 12),
                              ))
                          : Container(),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: _selectedIndex == (index - 1)
                        ? UnderseaStyles.hintColor
                        : null,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: UnderseaStyles.hintColor)))));
  }
}
