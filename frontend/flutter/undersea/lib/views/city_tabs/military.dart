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
                  UnderseaStyles.text('Birtokodban:'),
                  Expanded(child: Container()),
                  UnderseaStyles.text('5 db'),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text('Támadás/Védekezés:'),
                  Expanded(child: Container()),
                  UnderseaStyles.text('5/5'),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text('Zsold(/kör/példány)'),
                  Expanded(child: Container()),
                  UnderseaStyles.text('1 Gyöngy'),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text('Ellátmány:'),
                  Expanded(child: Container()),
                  UnderseaStyles.text('1 korall'),
                ],
              ),
              Row(
                children: [
                  UnderseaStyles.text('Ár:'),
                  Expanded(child: Container()),
                  UnderseaStyles.text('200 gyöngy'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: UnderseaStyles.underseaLogoColor,
                    child: Icon(
                      Icons.exposure_minus_1,
                      size: 35.0,
                    ),
                    padding: EdgeInsets.all(5.0),
                    shape: CircleBorder(),
                  ),
                  Text('0',
                      style: UnderseaStyles.listBold.copyWith(fontSize: 22)),
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: UnderseaStyles.underseaLogoColor,
                    child: Icon(
                      Icons.plus_one,
                      size: 35.0,
                    ),
                    padding: EdgeInsets.all(5.0),
                    shape: CircleBorder(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: UnderseaStyles.hintColor))*/
    ));
  }
}
