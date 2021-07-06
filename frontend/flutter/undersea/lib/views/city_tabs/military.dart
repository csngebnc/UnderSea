import 'package:flutter/material.dart';
import 'package:undersea/controllers/battle_data_controller.dart';
import 'package:undersea/controllers/country_data_controller.dart';

import 'package:undersea/lang/strings.dart';
import 'package:get/get.dart';
import 'package:undersea/models/response/battle_unit_dto.dart';
import 'package:undersea/models/response/buy_unit_details_dto.dart';
import 'package:undersea/models/response/buy_unit_dto.dart';
import 'package:undersea/models/response/unit_dto.dart';
import 'package:undersea/models/soldier.dart';
import 'package:undersea/styles/style_constants.dart';

class Military extends StatefulWidget {
  @override
  _MilitaryTabState createState() => _MilitaryTabState();
}

class _MilitaryTabState extends State<Military> {
  late Rx<List<UnitDto>> soldierList;
  var controller = Get.find<BattleDataController>();

  @override
  void initState() {
    soldierList = controller.unitTypesInfo;
    super.initState();
  }

  final countryData =
      Get.find<CountryDataController>().countryDetailsData.value;
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
            if (buyList[i] != 0)
              list.add(BuyUnitDetailsDto(
                  unitId: soldierList.value[i].id, count: buyList[i]));
          }
          controller.buyUnits(BuyUnitDto(units: list));
        },
        list: ListView.builder(
            itemCount: count,
            itemBuilder: (BuildContext context, int i) {
              if (i == 0)
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UnderseaStyles.infoPanel(Strings.military_manual_title.tr,
                          Strings.military_manual_hint.tr),
                      SizedBox(height: 25)
                    ]);
              if (i > soldierList.value.length * 2 - 1)
                return SizedBox(height: 100);
              if (i.isEven && i < soldierList.value.length * 2)
                return UnderseaStyles.divider();

              return GetBuilder<BattleDataController>(builder: (controller) {
                final allUnits = controller.allUnitsInfo.value;
                final spiesCount = controller.spiesInfo.value?.count;
                return _buildRow(i, soldierList, allUnits, spiesCount);
              });
            }));
  }

  int _calculateSoldierPrice() {
    int totalPrice = 0;
    /*for (int i = 0; i < soldierList.value.length; i++) {
      totalPrice +=
          soldierList.value[i].requriedMaterials![0].amount * buyList[i];
    }*/
    return totalPrice;
  }

  bool _canHireSoldiers() {
    if (buyList.every((element) => element == 0)) return false;
    //if (countryData!.pearl < _calculateSoldierPrice()) return false;
    return true;
  }

  List<Widget> _listResourceCost(UnitDto unit) {
    var costs = <Widget>[];
    bool isFirst = true;
    unit.requiredMaterials?.forEach((element) {
      costs.add(UnderseaStyles.text(
        (isFirst ? '' : ', ') + '${element.amount} ${element.name}',
      ));
      isFirst = false;
    });
    return costs;
  }

  Widget _buildRow(int index, Rx<List<UnitDto>> list,
      List<BattleUnitDto> totalUnits, int? spiesCount) {
    var idx = (index - 1) ~/ 2;
    var actualSoldier = list.value.elementAt(idx);
    var actualSoldierMax = totalUnits
        .firstWhere((element) => element.id == actualSoldier.id,
            orElse: () => BattleUnitDto(id: 0, name: 'name', count: 0))
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
                height: 110,
                width: 110,
                child: UnderseaStyles.assetIcon(
                    BattleDataController.imageNameMap[actualSoldier.name] ??
                        'shark'),
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
                      '${actualSoldier.attackPoint}/${actualSoldier.defensePoint}'),
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
                    children: [..._listResourceCost(actualSoldier)],
                  )
                  /*UnderseaStyles.text(
                      actualSoldier.requriedMaterials?[0].toString() ??
                          '' + Strings.pearl_cost.tr),*/
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
