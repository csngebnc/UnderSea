import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/battle_data_controller.dart';
import 'package:undersea/controllers/navbar_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/response/send_spy_dto.dart';
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
    if (spyNumber == 0) return false;
    return true;
  }

  //dummy data
  int spyNumber = 0;

  List<Soldier> soldierList = Get.find<BattleDataController>().soldierList;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleDataController>(builder: (controller) {
      return UnderseaStyles.tabSkeleton(
          buttonText: 'Küldés!',
          isDisabled: !_canAttack(),
          onButtonPressed: () {
            controller.sendSpies(SendSpyDto(
                spiedCountryId: controller.countryToBeAttacked!,
                spyCount: spyNumber));
            Get.find<BottomNavBarController>().selectedTab.value = 0;
          },
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
                    Text('$spyNumber/${controller.spiesInfo.value!.count}',
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
                        max: controller.spiesInfo.value!.count.toDouble(),
                        activeColor: UnderseaStyles.underseaLogoColor,
                        inactiveColor: Color(0x883B7DBD),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
