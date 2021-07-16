import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/constants.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';
import 'package:undersea/models/response/upgrade_dto.dart';
import 'package:undersea/services/upgrade_service.dart';
import 'package:undersea/widgets/building_image.dart';
import 'package:undersea/widgets/list_info_panel.dart';
import 'package:undersea/widgets/tab_skeleton.dart';

class Upgrades extends StatefulWidget {
  @override
  _UpgradesTabState createState() => _UpgradesTabState();
}

class _UpgradesTabState extends State<Upgrades> {
  UpgradeService controller = Get.find();
  int? _selectedIndex;
  late Rx<List<UpgradeDto>> upgradeList;

  @override
  void initState() {
    upgradeList = controller.upgradeInfoData;
    super.initState();
  }

  bool _canStartUpgrade() {
    if (_selectedIndex == null) return false;
    if (upgradeList.value.any((element) => element.isUnderConstruction)) {
      return false;
    }
    if (upgradeList.value[_selectedIndex!].doesExist) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return TabSkeleton(
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
              return GetBuilder<UpgradeService>(builder: (controller) {
                if (i == 0) {
                  return Column(
                    children: [
                      ListInfoPanel(
                          title: Strings.upgrades_manual_title.tr,
                          hint: Strings.upgrades_manual_hint.tr),
                      controller.upgradeInfoData.value.isEmpty
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
                    ],
                  );
                }
                if (i > upgradeList.value.length) {
                  return SizedBox(height: 100);
                }

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
            if ((index - 1) != _selectedIndex) {
              _selectedIndex = index - 1;
            } else {
              _selectedIndex = null;
            }
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
                              child: BuildingImage(
                                  name: Constants
                                      .buildingNameMap[actualUpgrade.name]!,
                                  additional: '@3x'),
                            ),
                            Text(actualUpgrade.name,
                                style: USText.listBold,
                                textAlign: TextAlign.center),
                            Text(
                              actualUpgrade.effects?.elementAt(0).name ??
                                  'effect',
                              style: USText.listRegular,
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
                                color: USColors.underseaLogoColor,
                              ))
                          : Container(),
                      actualUpgrade.isUnderConstruction
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'még ${actualUpgrade.remainingTime} kör',
                                style: TextStyle(
                                    color: USColors.underseaLogoColor,
                                    fontSize: 12),
                              ))
                          : Container(),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: _selectedIndex == (index - 1)
                        ? USColors.hintColor
                        : null,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: USColors.hintColor)))));
  }
}
