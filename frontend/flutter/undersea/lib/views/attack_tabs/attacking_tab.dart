import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/constants.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';
import 'package:undersea/models/response/attack_unit_dto.dart';
import 'package:undersea/models/response/battle_unit_dto.dart';
import 'package:undersea/models/response/send_attack_dto.dart';
import 'package:undersea/models/response/unit_dto.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/services/navbar_controller.dart';
import 'package:undersea/widgets/asset_icon.dart';
import 'package:undersea/widgets/list_info_panel.dart';
import 'package:undersea/widgets/tab_skeleton.dart';

class AttackingTab extends StatefulWidget {
  final Function onButtonPressed;

  const AttackingTab({Key? key, required this.onButtonPressed})
      : super(key: key);

  @override
  _AttackingTabState createState() => _AttackingTabState();
}

class _AttackingTabState extends State<AttackingTab> {
  late Rx<List<BattleUnitDto>> soldierList;
  late Rx<List<UnitDto>> unitTypeList;
  Map<int, List<BattleUnitDto>> groupedUnits = {};
  var controller = Get.find<BattleService>();
  Map<int, Map<int, int>> sliderValues = {};
  late int generalIndex;
  var mercenaryPrice = 0;

  @override
  void initState() {
    unitTypeList = controller.unitTypesInfo;
    soldierList = controller.availableUnitsInfo;
    for (int i = 0; i < unitTypeList.value.length; i++) {
      if (unitTypeList.value[i].name == 'Hadvezér') generalIndex = i + 1;
    }
    super.initState();
  }

  bool _canAttack() {
    if (sliderValues.entries.every((element) =>
        element.value.entries.every((element) => element.value == 0))) {
      return false;
    }
    if (sliderValues[generalIndex]?[1] == 0) {
      return false;
    }
    return true;
  }

  List<Widget>? buildSliderRows(int id) {
    var unitList = groupedUnits[id];
    return unitList
        ?.map((e) => e.count == 0
            ? Container()
            : Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                      ),
                      child: Text(e.level.toString(),
                          style: USText.listRegular.copyWith(height: 1.2)),
                    ),
                    Container(
                      height: 20,
                      child: Slider(
                        value: sliderValues[id]![e.level]!.toDouble(),
                        onChanged: (newValue) {
                          setState(() {
                            try {
                              sliderValues[id]![e.level] = newValue.round();
                            } catch (error) {
                              log('$error');
                            }
                          });
                          log('${sliderValues[id]![e.level]}');
                        },
                        min: 0,
                        max: e.count.toDouble(),
                        activeColor: USColors.underseaLogoColor,
                        inactiveColor: Color(0x883B7DBD),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text('${sliderValues[id]?[e.level]}/${e.count}',
                          style: USText.listRegular.copyWith(height: 1.2)),
                    ),
                  ],
                ),
              ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleService>(builder: (controller) {
      var itemCount = unitTypeList.value.length + 2;

      for (var soldier in soldierList()) {
        var keyExists = groupedUnits.containsKey(soldier.id);
        if (!keyExists) {
          sliderValues.addIf(!keyExists, soldier.id, {soldier.level: 0});
          groupedUnits.addIf(!keyExists, soldier.id, [soldier]);
        } else {
          sliderValues[soldier.id]?.addIf(
              !(sliderValues[soldier.id]?.containsKey(soldier.level) ?? false),
              soldier.level,
              0);
          groupedUnits[soldier.id]?.addIf(
              !(groupedUnits[soldier.id]?.contains(soldier) ?? false), soldier);
        }
      }

      return TabSkeleton(
          buttonText: Strings.lets_attack,
          isDisabled: !_canAttack(),
          onButtonPressed: () {
            var units = <AttackUnitDto>[];
            for (var entry in groupedUnits.entries) {
              for (var soldier in entry.value) {
                var count = sliderValues[soldier.id]?[soldier.level] ?? 0;
                units.addIf(
                    count.isGreaterThan(0),
                    AttackUnitDto(
                        unitId: soldier.id,
                        count: count,
                        level: soldier.level));
              }
            }

            controller.attack(SendAttackDto(
                attackedCountryId: controller.countryToBeAttacked!,
                units: units));
            Get.find<BottomNavBarController>().selectedTab.value = 0;
          },
          list: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int i) {
                if (i == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: USColors.underseaLogoColor,
                              size: 35,
                            ),
                            TextButton(
                              onPressed: () {
                                widget.onButtonPressed();
                              },
                              child: Text(Strings.back.tr,
                                  style: USText.buttonTextStyle.copyWith(
                                      color: USColors.underseaLogoColor,
                                      fontSize: 20)),
                            )
                          ],
                        ),
                      ),
                      ListInfoPanel(
                          title: Strings.second_step.tr,
                          hint: Strings.unit_select.tr,
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                }
                if (i == itemCount - 1) return SizedBox(height: 130);
                var actualSoldier = unitTypeList.value.elementAt(i - 1);

                if (actualSoldier.currentCount == 0 ||
                    actualSoldier.name == 'Felfedező') return Container();

                return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(actualSoldier.name,
                              style: USText.listBold
                                  .copyWith(height: 1.2, fontSize: 16)),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: AssetIcon(
                                    iconName: Constants
                                        .buildingNameMap[actualSoldier.name]!),
                              ),
                              /*Expanded(
                                child: */
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...?buildSliderRows(actualSoldier.id)
                                  ]),
                              //)
                            ],
                          )
                        ]));
              }));
    });
  }
}
