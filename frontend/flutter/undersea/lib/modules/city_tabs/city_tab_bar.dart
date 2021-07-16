import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/services/building_service.dart';
import 'package:undersea/services/upgrade_service.dart';
import 'package:undersea/modules/city_tabs/buildings.dart';
import 'package:undersea/modules/city_tabs/military.dart';
import 'package:undersea/modules/city_tabs/upgrades.dart';
import 'package:undersea/widgets/tab_piece.dart';

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
                color: USColors.menuDarkBlue,
                child: TabBar(
                  indicatorColor: USColors.underseaLogoColor,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  tabs: [
                    TabPiece(Strings.my_city.tr),
                    TabPiece(Strings.upgrades.tr),
                    TabPiece(Strings.my_forces.tr),
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
