import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:undersea/controllers/upgrades_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/response/upgrade_dto.dart';
import 'package:undersea/models/upgrade.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:get/get.dart';

class Upgrades extends StatefulWidget {
  @override
  _UpgradesTabState createState() => _UpgradesTabState();
}

class _UpgradesTabState extends State<Upgrades> {
  UpgradesController controller = Get.find();
  int? _selectedIndex;
  late Rx<List<UpgradeDto>> upgradeList;

  @override
  void initState() {
    upgradeList = controller.upgradeInfoData;
    super.initState();
  }

  bool _canStartUpgrade() {
    if (_selectedIndex == null) return false;
    if (upgradeList.value.any((element) => element.isUnderConstruction))
      return false;
    if (upgradeList.value[_selectedIndex!].doesExist) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return UnderseaStyles.tabSkeleton(
        onButtonPressed: () {
          controller.upgradeInfoData.value[_selectedIndex!].remainingTime = 15;
          controller.upgradeInfoData.value[_selectedIndex!]
              .isUnderConstruction = true;
          controller.buyUpgrade(upgradeList.value[_selectedIndex!].id);
          controller.update();

          setState(() {
            _selectedIndex = null;
          });
        },
        isDisabled: !_canStartUpgrade(),
        list: ListView.builder(
            itemCount: 8,
            itemBuilder: (BuildContext context, int i) {
              if (i == 0)
                return UnderseaStyles.infoPanel(
                    Strings.upgrades_manual_title.tr,
                    Strings.upgrades_manual_hint.tr);
              if (i > upgradeList.value.length) return SizedBox(height: 100);

              return GetBuilder<UpgradesController>(builder: (controller) {
                final upgradeListValue = controller.upgradeInfoData.value;
                return _buildRow(i, upgradeListValue);
              });
            }));
  }

  Widget _buildRow(int index, List<UpgradeDto> list) {
    var actualUpgrade = list[index - 1];
    return ListTile(
        onTap: () {
          setState(() {
            if ((index - 1) != _selectedIndex)
              _selectedIndex = index - 1;
            else
              _selectedIndex = null;
          });
        },
        title: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: UnderseaStyles.buildingImage(
                                  controller.imageNameMap[actualUpgrade.name]! +
                                      '@3x'),
                            ),
                            Text(actualUpgrade.name,
                                style: UnderseaStyles.listBold,
                                textAlign: TextAlign.center),
                            Text(
                              actualUpgrade.effects?.elementAt(0).name ??
                                  'effect',
                              style: UnderseaStyles.listRegular,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      actualUpgrade.doesExist
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.done_outline_sharp,
                                color: UnderseaStyles.underseaLogoColor,
                              ))
                          : Container(),
                      actualUpgrade.isUnderConstruction
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'még ${actualUpgrade.remainingTime} kör',
                                style: TextStyle(
                                    color: UnderseaStyles.underseaLogoColor,
                                    fontSize: 12),
                              ))
                          : Container(),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: _selectedIndex == (index - 1)
                        ? UnderseaStyles.hintColor
                        : null,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: UnderseaStyles.hintColor)))));
  }
}
