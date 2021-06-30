import 'package:flutter/material.dart';
import 'package:undersea/controllers/buildings_controller.dart';
import 'package:undersea/controllers/player_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/building.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:get/get.dart';

class Buildings extends StatefulWidget {
  @override
  _BuildingsTabState createState() => _BuildingsTabState();
}

class _BuildingsTabState extends State<Buildings> {
  int? _selectedIndex;
  List<Building> buildingList = Get.find<BuildingsController>().buildingList;
  PlayerController playerController = Get.find<PlayerController>();
  @override
  Widget build(BuildContext context) {
    return UnderseaStyles.tabSkeleton(
        isDisabled: !_canStartBuilding(),
        list: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int i) {
              if (i == 0)
                return UnderseaStyles.infoPanel(
                    Strings.buildings_manual_title.tr,
                    Strings.buildings_manual_hint.tr);
              if (i > buildingList.length) return SizedBox(height: 100);

              return _buildRow(i, buildingList);
            }));
  }

  bool _canStartBuilding() {
    if (_selectedIndex == null) return false;
    if (buildingList.any((element) => element.isInProgress)) return false;
    if (buildingList[_selectedIndex!].price >
        playerController.playerData.value.pearlAmount) return false;
    return true;
  }

  Widget _buildRow(int index, List<Building> list) {
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
                                  actualBuilding.imageName + '@3x'),
                            ),
                            Text(actualBuilding.name,
                                style: UnderseaStyles.listBold),
                            Text(actualBuilding.effect1,
                                style: UnderseaStyles.listBold),
                            actualBuilding.effect2 != null
                                ? Text(actualBuilding.effect2!,
                                    style: UnderseaStyles.listBold)
                                : Container(),
                            Text(
                                actualBuilding.currentAmount.toString() +
                                    Strings.amount.tr,
                                style: UnderseaStyles.listRegular),
                            Text(
                                actualBuilding.price.toString() +
                                    Strings.pearl_cost_per_unit.tr,
                                style: UnderseaStyles.listRegular)
                          ],
                        ),
                      ),
                      actualBuilding.isInProgress
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                Strings.rounds_remaining.trParams({
                                  'round': actualBuilding.availableIn.toString()
                                })!,
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
