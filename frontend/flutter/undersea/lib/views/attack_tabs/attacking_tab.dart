import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/battle_data_controller.dart';
import 'package:undersea/controllers/navbar_controller.dart';

import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/response/attack_unit_dto.dart';
import 'package:undersea/models/response/send_attack_dto.dart';
import 'package:undersea/models/response/unit_dto.dart';

import 'package:undersea/styles/style_constants.dart';

class AttackingTab extends StatefulWidget {
  final Function onButtonPressed;

  const AttackingTab({Key? key, required this.onButtonPressed})
      : super(key: key);

  @override
  _AttackingTabState createState() => _AttackingTabState();
}

class _AttackingTabState extends State<AttackingTab> {
  late Rx<List<UnitDto>> soldierList;
  var controller = Get.find<BattleDataController>();

  @override
  void initState() {
    soldierList = controller.unitTypesInfo;
    for (int i = 0; i < soldierList.value.length; i++) {
      if (soldierList.value[i].name == 'Hadvezér') generalIndex = i;
    }
    sliderValues =
        List<int>.generate(soldierList.value.length /** 3*/, (index) => 0);
    super.initState();
  }

  bool _canAttack() {
    if (sliderValues.every((element) => element == 0)) return false;
    if (sliderValues[generalIndex] == 0) return false;
    return true;
  }

  var sliderValues = List<int>.generate(3, (index) => 0);
  late int generalIndex;
  var mercenaryPrice = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleDataController>(builder: (controller) {
      var itemCount = controller.unitTypesInfo.value.length + 2;

      return UnderseaStyles.tabSkeleton(
          buttonText: Strings.lets_attack,
          isDisabled: !_canAttack(),
          onButtonPressed: () {
            var units = <AttackUnitDto>[];
            for (int i = 0; i < sliderValues.length; i++) {
              if (sliderValues[i] != 0) {
                units.add(AttackUnitDto(
                    unitId: soldierList.value[i].id,
                    count: sliderValues[i],
                    level: 2)); // TODO: átírni nem beégetettre
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
                              color: UnderseaStyles.underseaLogoColor,
                              size: 35,
                            ),
                            TextButton(
                              onPressed: () {
                                widget.onButtonPressed();
                              },
                              child: Text(Strings.back.tr,
                                  style: UnderseaStyles.buttonTextStyle
                                      .copyWith(
                                          color:
                                              UnderseaStyles.underseaLogoColor,
                                          fontSize: 20)),
                            )
                          ],
                        ),
                      ),
                      UnderseaStyles.infoPanel(
                          Strings.second_step.tr, Strings.unit_select.tr,
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                }
                if (i == itemCount - 1) return SizedBox(height: 130);
                var actualSoldier = soldierList.value.elementAt(i - 1);

                if (actualSoldier.name == 'Felfedező' ||
                    actualSoldier.currentCount == 0) return Container();

                return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(soldierList.value[i - 1].name,
                              style: UnderseaStyles.listBold
                                  .copyWith(height: 1.2, fontSize: 16)),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: UnderseaStyles.assetIcon(
                                    BattleDataController
                                        .imageNameMap[actualSoldier.name]!),
                              ),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 25,
                                            ),
                                            child: Text('1. ',
                                                style: UnderseaStyles
                                                    .listRegular
                                                    .copyWith(height: 1.2)),
                                          ),
                                          Container(
                                            height: 20,
                                            child: Slider(
                                              value: sliderValues[i - 1]
                                                  .toDouble(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  var amountBeforeChange =
                                                      sliderValues[i - 1];
                                                  sliderValues[i - 1] =
                                                      newValue.round();
                                                  mercenaryPrice = (mercenaryPrice +
                                                          newValue -
                                                          amountBeforeChange *
                                                              1) //actualSoldier.price)
                                                      .toInt();
                                                });
                                              },
                                              min: 0,
                                              max: actualSoldier.currentCount
                                                  .toDouble(),
                                              activeColor: UnderseaStyles
                                                  .underseaLogoColor,
                                              inactiveColor: Color(0x883B7DBD),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                            ),
                                            child: Text(
                                                '${sliderValues[i - 1]}/${actualSoldier.currentCount}',
                                                style: UnderseaStyles
                                                    .listRegular
                                                    .copyWith(height: 1.2)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 25,
                                            ),
                                            child: Text('1. ',
                                                style: UnderseaStyles
                                                    .listRegular
                                                    .copyWith(height: 1.2)),
                                          ),
                                          Container(
                                            height: 20,
                                            child: Slider(
                                              value: sliderValues[i - 1]
                                                  .toDouble(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  var amountBeforeChange =
                                                      sliderValues[i - 1];
                                                  sliderValues[i - 1] =
                                                      newValue.round();
                                                  mercenaryPrice = (mercenaryPrice +
                                                          newValue -
                                                          amountBeforeChange *
                                                              1) //actualSoldier.price)
                                                      .toInt();
                                                });
                                              },
                                              min: 0,
                                              max: actualSoldier.currentCount
                                                  .toDouble(),
                                              activeColor: UnderseaStyles
                                                  .underseaLogoColor,
                                              inactiveColor: Color(0x883B7DBD),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                            ),
                                            child: Text(
                                                '${sliderValues[i - 1]}/${actualSoldier.currentCount}',
                                                style: UnderseaStyles
                                                    .listRegular
                                                    .copyWith(height: 1.2)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 25,
                                            ),
                                            child: Text('1. ',
                                                style: UnderseaStyles
                                                    .listRegular
                                                    .copyWith(height: 1.2)),
                                          ),
                                          Container(
                                            height: 20,
                                            child: Slider(
                                              value: sliderValues[i - 1]
                                                  .toDouble(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  var amountBeforeChange =
                                                      sliderValues[i - 1];
                                                  sliderValues[i - 1] =
                                                      newValue.round();
                                                  mercenaryPrice = (mercenaryPrice +
                                                          newValue -
                                                          amountBeforeChange *
                                                              1) //actualSoldier.price)
                                                      .toInt();
                                                });
                                              },
                                              min: 0,
                                              max: actualSoldier.currentCount
                                                  .toDouble(),
                                              activeColor: UnderseaStyles
                                                  .underseaLogoColor,
                                              inactiveColor: Color(0x883B7DBD),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                            ),
                                            child: Text(
                                                '${sliderValues[i - 1]}/${actualSoldier.currentCount}',
                                                style: UnderseaStyles
                                                    .listRegular
                                                    .copyWith(height: 1.2)),
                                          ),
                                        ],
                                      ),
                                    ]),
                              )
                            ],
                          )
                        ]));
              }));
    });
  }
}
