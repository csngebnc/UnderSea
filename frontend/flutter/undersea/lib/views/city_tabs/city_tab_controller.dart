import 'package:flutter/material.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/city_tabs/buildings.dart';
import 'package:undersea/views/city_tabs/military.dart';
import 'package:undersea/views/city_tabs/upgrades.dart';

class CityTabBar extends StatelessWidget {
  CityTabBar();
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
                  //labelColor: UnderseaStyles.menuDarkBlue,
                  //unselectedLabelColor: UnderseaStyles.menuDarkBlue,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 5,

                  tabs: [
                    UnderseaStyles.tab("Épületek"),
                    UnderseaStyles.tab("Fejlesztések"),
                    UnderseaStyles.tab("Sereg"),
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
