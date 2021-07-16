import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/models/response/battle_unit_dto.dart';
import 'package:undersea/models/response/buy_unit_details_dto.dart';
import 'package:undersea/models/response/buy_unit_dto.dart';
import 'package:undersea/models/response/unit_dto.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/services/country_service.dart';
import 'package:undersea/styles/style_constants.dart';

class Military extends StatefulWidget {
  @override
  _MilitaryTabState createState() => _MilitaryTabState();
}

class _MilitaryTabState extends State<Military> {
  late Rx<List<UnitDto>> soldierList;
  var controller = Get.find<BattleService>();

  @override
  void initState() {
    soldierList = controller.unitTypesInfo;
    super.initState();
  }

  final countryData = Get.find<CountryService>().countryDetailsData.value;
  late List<int> buyList =
      List.generate(soldierList.value.length, (index) => 0);
  late int count = 2 + soldierList.value.length * 2 - 1;
  @override
  Widget build(BuildContext context) {
    return UnderseaStyles.tabSkeleton(
        isDisabled: !_canHireSoldiers(),
        onButtonPressed: () {
          var list = <BuyUnitDetailsDto>[];

          for (int i = 0; i < soldierList.value.length; i++) {
            if (buyList[i] != 0) {
              list.add(BuyUnitDetailsDto(
                  unitId: soldierList.value[i].id, count: buyList[i]));
            }
          }
          controller.buyUnits(BuyUnitDto(units: list));
        },
        list: ListView.builder(
            itemCount: count,
            itemBuilder: (BuildContext context, int i) {
              return GetBuilder<BattleService>(builder: (controller) {
                if (i == 0) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UnderseaStyles.infoPanel(
                            Strings.military_manual_title.tr,
                            Strings.military_manual_hint.tr),
                        SizedBox(height: 25),
                        controller.unitTypesInfo.value.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: const SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator()),
                                ),
                              )
                            : Container()
                      ]);
                }
                if (i > soldierList.value.length * 2 - 1) {
                  return SizedBox(height: 100);
                }
                if (i.isEven && i < soldierList.value.length * 2) {
                  return UnderseaStyles.divider();
                }

                final allUnits = controller.allUnitsInfo.value;
                final spiesCount = controller.spiesInfo.value?.count;
                return _buildRow(i, soldierList, allUnits, spiesCount);
              });
            }));
  }

  bool _canHireSoldiers() {
    if (buyList.every((element) => element == 0)) return false;

    Map<int, int> materialIdToAmount = {
      for (var item in countryData!.materials!) item.id: item.amount
    };
    bool areResourcesEnough = true;
    var unitsToBeBought = 0;

    for (int i = 0; i < soldierList.value.length; i++) {
      unitsToBeBought += buyList[i];
      soldierList.value[i].requiredMaterials?.forEach((mat) {
        late int newValue;
        var original = materialIdToAmount[mat.id];
        if (original != null) newValue = original - mat.amount * buyList[i];
        if (newValue < 0) {
          areResourcesEnough = false;
          return;
        }
        materialIdToAmount[mat.id] = newValue;
      });
    }
    var allUnitsCount = 0;
    controller.allUnitsInfo.value.forEach((element) {
      allUnitsCount += element.count;
    });

    if (countryData!.maxUnitCount < allUnitsCount + unitsToBeBought) {
      return false;
    }

    return areResourcesEnough;
  }

  List<Widget> _listResourceCost(UnitDto unit) =>
      unit.requiredMaterials
          ?.map((e) => UnderseaStyles.text(
                '  ${e.amount} ${e.name}',
              ))
          .toList() ??
      [];

  Widget _buildRow(int index, Rx<List<UnitDto>> list,
      List<BattleUnitDto> totalUnits, int? spiesCount) {
    var idx = (index - 1) ~/ 2;
    var actualSoldier = list.value.elementAt(idx);

    var actualSoldierMax = totalUnits
        .firstWhere((element) => element.id == actualSoldier.id,
            orElse: () =>
                BattleUnitDto(id: 0, name: 'name', count: 0, level: 1))
        .count;

    var isSpy = actualSoldier.name == 'Felfedező';
    return ListTile(
        title: Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.center,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: UnderseaStyles.assetIcon(
                    BattleService.imageNameMap[actualSoldier.name] ?? 'shark'),
              ),
              SizedBox(height: 8),
              Text(actualSoldier.name,
                  style: UnderseaStyles.listBold.copyWith(fontSize: 19),
                  textAlign: TextAlign.center),
              SizedBox(height: 8),
              Row(
                children: [
                  UnderseaStyles.text(Strings.you_possess.tr),
                  Expanded(child: Container()),
                  UnderseaStyles.text((isSpy
                          ? spiesCount.toString()
                          : actualSoldierMax.toString()) +
                      Strings.amount.tr),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text(Strings.attack_defence.tr),
                  Expanded(child: Container()),
                  UnderseaStyles.text(
                      '${actualSoldier.unitLevels?.first.attackPoint}/${actualSoldier.unitLevels?.first.defensePoint}'),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text(Strings.mercenary_payment.tr),
                  Expanded(child: Container()),
                  UnderseaStyles.text(
                      actualSoldier.mercenaryPerRound.toString() +
                          Strings.pearl_cost.tr),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text(Strings.supply_needs.tr),
                  Expanded(child: Container()),
                  UnderseaStyles.text(actualSoldier.supplyPerRound.toString() +
                      Strings.coral.tr),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text(Strings.price.tr),
                  Expanded(child: Container()),
                  Row(
                    children: _listResourceCost(actualSoldier),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UnderseaStyles.circleButton("minus", onPressed: () {
                    setState(() {
                      if (buyList[idx] == 0) return;
                      --buyList[idx];
                    });
                  }),
                  Text(buyList[idx].toString(),
                      style: UnderseaStyles.listBold.copyWith(fontSize: 22)),
                  UnderseaStyles.circleButton("plus", onPressed: () {
                    setState(() {
                      ++buyList[idx];
                    });
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
