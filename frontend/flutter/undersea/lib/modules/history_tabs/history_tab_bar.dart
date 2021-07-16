import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/modules/history_tabs/attack_history.dart';
import 'package:undersea/modules/history_tabs/event_log.dart';
import 'package:undersea/modules/history_tabs/spy_history.dart';
import 'package:undersea/widgets/tab_piece.dart';

class HistoryTabBar extends StatelessWidget {
  HistoryTabBar(this.onButtonPressed);
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
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
                    TabPiece(Strings.events.tr)
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              AttackHistoryPage(),
              SpyingHistoryPage(),
              EventLogPage()
            ],
          ),
        ),
      ),
    );
  }
}
