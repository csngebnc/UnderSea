import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/battle_data_controller.dart';
import 'package:undersea/controllers/navbar_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/response/send_spy_dto.dart';
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

  int spyNumber = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleDataController>(builder: (controller) {
      return UnderseaStyles.tabSkeleton(
          buttonText: Strings.send.tr,
          isDisabled: !_canAttack(),
          onButtonPressed: () {
            controller.sendSpies(SendSpyDto(
                spiedCountryId: controller.countryToBeAttacked!,
                spyCount: spyNumber));
            Get.find<BottomNavBarController>().selectedTab.value = 0;
          },
          list: Column(
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
                child: UnderseaStyles.infoPanel(
                    Strings.second_step.tr, Strings.spying_second_step.tr,
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 70,
                width: 70,
                child: UnderseaStyles.assetIcon('dora'),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(Strings.spy.tr,
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
                            spyNumber = newValue.round();
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
