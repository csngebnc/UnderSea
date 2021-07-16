import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/services/building_service.dart';
import 'package:undersea/services/upgrade_service.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/city_tabs/buildings.dart';
import 'package:undersea/views/city_tabs/military.dart';
import 'package:undersea/views/city_tabs/upgrades.dart';

class CityTabBar extends StatelessWidget {
  CityTabBar() {
    Get.find<UpgradeService>().getUpgradeDetails();
    Get.find<BuildingService>().getBuildingDetails();
    Get.find<BattleService>().getUnitTypes();
    Get.find<BattleService>().getAllUnits();
    Get.find<BattleService>().getSpies();
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
