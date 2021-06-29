import 'package:flutter/material.dart';
import 'package:undersea/lang/strings.dart';
import 'package:get/get.dart';
import 'package:undersea/models/soldier.dart';
import 'package:undersea/styles/style_constants.dart';

class Military extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var soldierList = <Soldier>[
      Soldier(
          amount: 0,
          attack: 5,
          defence: 5,
          payment: 1,
          supplyNeeds: 1,
          name: 'Lézercápa',
          price: 200,
          iconName: 'shark'),
      Soldier(
          amount: 5,
          attack: 2,
          defence: 6,
          payment: 1,
          supplyNeeds: 1,
          name: 'Rohamfóka',
          price: 50,
          iconName: 'seal'),
      Soldier(
          amount: 0,
          attack: 6,
          defence: 2,
          payment: 1,
          supplyNeeds: 1,
          name: 'Csatacsikó',
          price: 50,
          iconName: 'seahorse')
    ];
    var count = 2 + soldierList.length * 2 - 1;
    return UnderseaStyles.tabSkeleton(
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
              if (i > soldierList.length * 2 - 1) return SizedBox(height: 100);
              if (i.isEven && i < soldierList.length * 2)
                return UnderseaStyles.divider();

              return _buildRow(i, soldierList);
            }));
  }

  Widget _buildRow(int index, List<Soldier> list) {
    var actualSoldier = list.elementAt((index - 1) ~/ 2);
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
                child: UnderseaStyles.assetIcon(actualSoldier.iconName),
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
                  UnderseaStyles.text(
                      actualSoldier.amount.toString() + Strings.amount.tr),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text(Strings.attack_defence.tr),
                  Expanded(child: Container()),
                  UnderseaStyles.text(actualSoldier.attackDefence()),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text(Strings.mercenary_payment.tr),
                  Expanded(child: Container()),
                  UnderseaStyles.text(
                      actualSoldier.payment.toString() + Strings.pearl_cost.tr),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text(Strings.supply_needs.tr),
                  Expanded(child: Container()),
                  UnderseaStyles.text(
                      actualSoldier.supplyNeeds.toString() + Strings.coral.tr),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text(Strings.price.tr),
                  Expanded(child: Container()),
                  UnderseaStyles.text(
                      actualSoldier.price.toString() + Strings.pearl_cost.tr),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UnderseaStyles.circleButton("minus"),
                  Text('0',
                      style: UnderseaStyles.listBold.copyWith(fontSize: 22)),
                  UnderseaStyles.circleButton("plus"),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
