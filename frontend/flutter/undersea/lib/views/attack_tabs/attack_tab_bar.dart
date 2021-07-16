import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/views/attack_tabs/spying_tab.dart';
import 'package:undersea/widgets/tab_piece.dart';

import 'attacking_tab.dart';

class AttackTabBar extends StatelessWidget {
  AttackTabBar(this.onButtonPressed);
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    Get.find<BattleService>().getUnitTypes();
    Get.find<BattleService>().getAllUnits();
    Get.find<BattleService>().getSpies();
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(60.0, 60.0),
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
                    TabPiece(Strings.battle.tr),
                    TabPiece(Strings.spying.tr),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              AttackingTab(onButtonPressed: onButtonPressed),
              SpyingTab(onButtonPressed: onButtonPressed),
            ],
          ),
        ),
      ),
    );
  }
}
