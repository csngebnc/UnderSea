import 'package:flutter/material.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/attack_tabs/spying_tab.dart';

import 'attacking_tab.dart';

class AttackTabBar extends StatelessWidget {
  AttackTabBar(this.onButtonPressed);
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(60.0, 60.0),
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
                    UnderseaStyles.tab('Harc'),
                    UnderseaStyles.tab('Felfedezés'),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              AttackingTab(onButtonPressed: onButtonPressed),
              SpyingTab(onButtonPressed: onButtonPressed)
            ],
          ),
        ),
      ),
    );
  }
}
