import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/soldiers_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/soldier.dart';
import 'package:undersea/styles/style_constants.dart';

class SpyingTab extends StatefulWidget {
  final Function onButtonPressed;

  const SpyingTab({Key? key, required this.onButtonPressed}) : super(key: key);

  @override
  _SpyingTabState createState() => _SpyingTabState();
}

class _SpyingTabState extends State<SpyingTab> {
  bool _canAttack() {
    if (spyNumber * spyPrice >= 40000) return false;
    if (spyNumber == 0) return false;
    return true;
  }

  //dummy data
  int spyNumber = 0;
  int maxSpyNumber = 300;
  int spyPrice = 50;

  List<Soldier> soldierList = Get.find<SoldiersController>().soldierList;
  @override
  Widget build(BuildContext context) {
    return UnderseaStyles.tabSkeleton(
        buttonText: 'Küldés!',
        isDisabled: !_canAttack(),
        onButtonPressed: widget.onButtonPressed,
        list: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
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
                        style: UnderseaStyles.buttonTextStyle.copyWith(
                            color: UnderseaStyles.underseaLogoColor,
                            fontSize: 20)),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: UnderseaStyles.infoPanel(Strings.second_step.tr,
                  'Állítsd be, hány felfedezőt szeretnél küldeni:',
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: UnderseaStyles.assetIcon('dora'),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Felfedező',
                      style: UnderseaStyles.listBold
                          .copyWith(height: 1.2, fontSize: 22)),
                  SizedBox(height: 5),
                  Text('$spyNumber/$maxSpyNumber',
                      style: UnderseaStyles.listRegular
                          .copyWith(height: 1.2, fontSize: 20)),
                  SizedBox(height: 8),
                  Container(
                    height: 20,
                    width: 300,
                    child: Slider(
                      value: spyNumber.toDouble(),
                      onChanged: (newValue) {
                        setState(() {
                          //var amountBeforeChange = spyNumber;
                          spyNumber = newValue.round();
                          /*mercenaryPrice = (mercenaryPrice +
                                  newValue -
                                  amountBeforeChange * spyPrice)
                              .toInt();*/
                        });
                      },
                      min: 0,
                      max: maxSpyNumber.toDouble(),
                      activeColor: UnderseaStyles.underseaLogoColor,
                      inactiveColor: Color(0x883B7DBD),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )

        /*ListView.builder(
            itemCount: 5,
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
                                style: UnderseaStyles.buttonTextStyle.copyWith(
                                    color: UnderseaStyles.underseaLogoColor,
                                    fontSize: 20)),
                          )
                        ],
                      ),
                    ),
                    UnderseaStyles.infoPanel(
                        Strings.second_step.tr, 'Állítsd be, hány kémet szeretnél küldeni:',
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
                    SizedBox(
                      height: 20,
                    )
                  ],
                );*/

        /*if (i == 4) return SizedBox(height: 100);
              return Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: UnderseaStyles.assetIcon(
                            soldierList[i - 1].iconName),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 25,
                              ),
                              child: Text(
                                  '${soldierList[i - 1].name} ${sliderValues[i - 1]}/${soldierList[i - 1].available}',
                                  style: UnderseaStyles.listRegular
                                      .copyWith(height: 1.2)),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 20,
                              child: Slider(
                                value: sliderValues[i - 1].toDouble(),
                                onChanged: (newValue) {
                                  setState(() {
                                    var amountBeforeChange =
                                        sliderValues[i - 1];
                                    sliderValues[i - 1] = newValue.round();
                                    mercenaryPrice = (mercenaryPrice +
                                            newValue -
                                            amountBeforeChange *
                                                soldierList[i - 1].price)
                                        .toInt();
                                  });
                                },
                                min: 0,
                                max: soldierList[i - 1].available.toDouble(),
                                activeColor: UnderseaStyles.underseaLogoColor,
                                inactiveColor: Color(0x883B7DBD),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));*/
        ); //}));
  }
}
