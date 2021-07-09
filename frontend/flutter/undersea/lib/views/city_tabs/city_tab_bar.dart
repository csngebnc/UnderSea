import 'package:flutter/material.dart';
import 'package:undersea/controllers/battle_data_controller.dart';
import 'package:undersea/controllers/building_data_controller.dart';
import 'package:undersea/controllers/upgrades_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/city_tabs/buildings.dart';
import 'package:undersea/views/city_tabs/military.dart';
import 'package:undersea/views/city_tabs/upgrades.dart';
import 'package:get/get.dart';

class CityTabBar extends StatelessWidget {
  CityTabBar() {
    Get.find<UpgradesController>().getUpgradeDetails();
    Get.find<BuildingDataController>().getBuildingDetails();
    Get.find<BattleDataController>().getUnitTypes();
    Get.find<BattleDataController>().getAllUnits();
    Get.find<BattleDataController>().getSpies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(100.0, 100.0),
            child: Container(
              height: 50,
              child: Material(
                color: UnderseaStyles.menuDarkBlue,
                child: TabBar(
                  indicatorColor: UnderseaStyles.underseaLogoColor,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  tabs: [
                    UnderseaStyles.tab(Strings.my_city.tr),
                    UnderseaStyles.tab(Strings.upgrades.tr),
                    UnderseaStyles.tab(Strings.my_forces.tr),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Buildings(),
              Upgrades(),
              Military(),
            ],
          ),
        ),
      ),
    );
  }
}
