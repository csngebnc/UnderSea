import 'package:flutter/material.dart';
import 'package:undersea/controllers/building_data_controller.dart';
import 'package:undersea/controllers/country_data_controller.dart';

import 'package:undersea/lang/strings.dart';

import 'package:undersea/models/response/building_details_dto.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:get/get.dart';

class Buildings extends StatefulWidget {
  @override
  _BuildingsTabState createState() => _BuildingsTabState();
}

class _BuildingsTabState extends State<Buildings> {
  BuildingDataController controller = Get.find();
  late Rx<List<BuildingDetailsDto>> buildingList;

  int? _selectedIndex;

  @override
  void initState() {
    buildingList = controller.buildingInfoData;
    super.initState();
  }

  CountryDataController playerController = Get.find();
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
            itemCount: 4,
            itemBuilder: (BuildContext context, int i) {
              if (i == 0)
                return UnderseaStyles.infoPanel(
                    Strings.buildings_manual_title.tr,
                    Strings.buildings_manual_hint.tr);
              if (i > buildingList.value.length) return SizedBox(height: 100);

              return GetBuilder<BuildingDataController>(builder: (controller) {
                final buildingListValue = controller.buildingInfoData.value;
                return _buildRow(i, buildingListValue);
              });
            }));
  }

  bool _canStartBuilding() {
    if (_selectedIndex == null) return false;
    if (buildingList.value.any((element) => element.underConstruction))
      return false;
    if (buildingList.value[_selectedIndex!].price >
        playerController.countryDetailsData.value!.pearl) return false;
    return true;
  }

  List<Widget> _listEffects(BuildingDetailsDto building) {
    var effects = <Widget>[];
    building.effects?.forEach((element) {
      effects
          .add(Text(element.name ?? 'effect', style: UnderseaStyles.listBold));
    });
    return effects;
  }

  Widget _buildRow(int index, List<BuildingDetailsDto> list) {
    var actualBuilding = list[index - 1];
    return ListTile(
        onTap: () {
          setState(() {
            if ((index - 1) != _selectedIndex)
              _selectedIndex = index - 1;
            else
              _selectedIndex = null;
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
                                  BuildingDataController
                                          .imageNameMap[actualBuilding.name]! +
                                      '@3x'),
                            ),
                            Text(actualBuilding.name!,
                                style: UnderseaStyles.listBold),
                            ..._listEffects(actualBuilding),
                            Text(
                                actualBuilding.count.toString() +
                                    Strings.amount.tr,
                                style: UnderseaStyles.listRegular),
                            Text(
                                actualBuilding.price.toString() +
                                    Strings.pearl_cost_per_unit.tr,
                                style: UnderseaStyles.listRegular)
                          ],
                        ),
                      ),
                      actualBuilding.underConstruction
                          ? Padding(
                              //////////////////////////////////////////////////////////////////////////////////////////
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'épül',
                                //Strings.under_construction.tr,
                                style: TextStyle(
                                    color: UnderseaStyles.underseaLogoColor,
                                    fontSize: 16),
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
