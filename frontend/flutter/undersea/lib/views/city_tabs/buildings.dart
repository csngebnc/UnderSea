import 'package:flutter/material.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/building.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:get/get.dart';

class Buildings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buildingList = <Building>[
      Building(
          name: 'Zátonyvár',
          effect1: '50 ember-t ad a népességhez',
          effect2: '200 krumplit termel körönként',
          currentAmount: 1,
          price: 35,
          availableIn: 0,
          imageName: "zatonyvar",
          isInProgress: false,
          isAvailable: true),
      Building(
          name: 'Áramlásirányító',
          effect1: '200 egységnek nyújt szállást',
          currentAmount: 1,
          price: 35,
          availableIn: 4,
          imageName: "aramlasiranyito",
          isInProgress: true,
          isAvailable: false),
    ];

    return UnderseaStyles.tabSkeleton(
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

  Widget _buildRow(int index, List<Building> list) {
    var actualBuilding = list[index - 1];
    return ListTile(
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
                      actualBuilding.isAvailable
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.done_outline_sharp,
                                color: UnderseaStyles.underseaLogoColor,
                              ))
                          : Container(),
                      actualBuilding.isInProgress
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                Strings.rounds_remaining.trParams({
                                  'round': actualBuilding.availableIn.toString()
                                })!,

                                //'még ${actualBuilding.availableIn} kör',
                                style: TextStyle(
                                    color: UnderseaStyles.underseaLogoColor,
                                    fontSize: 16),
                              ))
                          : Container(),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: UnderseaStyles.hintColor)))));
  }
}
