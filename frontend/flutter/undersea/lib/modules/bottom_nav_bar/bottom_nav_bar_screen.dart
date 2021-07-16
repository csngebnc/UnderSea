import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';
import 'package:undersea/modules/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:undersea/modules/city_tabs/city_tab_bar.dart';
import 'package:undersea/modules/history_tabs/history_tab_bar.dart';
import 'package:undersea/widgets/app_bar_title.dart';
import 'package:undersea/widgets/asset_icon.dart';
import 'package:undersea/widgets/image_icon.dart';

import '../attack_page.dart';
import '../home_page.dart';
import '../profile.dart';

class BottomNavigationBarScreen extends GetView<BottomNavigationBarController> {
  static const routeName = 'home';

  final List<Widget> _appbarTitleOptions = <Widget>[
    SizedBox(
      height: 35,
      width: 100,
      child: USImageIcon(
          assetName: "undersea_small", color: USColors.underseaLogoColor),
    ),
    AppBarTitle(text: Strings.my_city.tr),
    AppBarTitle(text: Strings.attack.tr),
    AppBarTitle(text: Strings.my_forces.tr),
  ];
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CityTabBar(),
    AttackPage(),
    HistoryTabBar(() {})
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          toolbarHeight: controller.tabIndex == 0 ? 85 : 60,
          backgroundColor: USColors.hintColor,
          actions: [
            if (controller.tabIndex == 0)
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(ProfilePage());
                      },
                      child: SizedBox(
                          height: 40,
                          child: AssetIcon(iconName: "profile", iconSize: 42))))
          ],
          title: _appbarTitleOptions[controller.tabIndex],
        ),
        body: Center(
          child: _widgetOptions[controller.tabIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: USColors.gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: USImageIcon(assetName: 'tab_home'),
                label: Strings.home_page.tr,
              ),
              BottomNavigationBarItem(
                icon: USImageIcon(assetName: 'tab_city'),
                label: Strings.my_city.tr,
              ),
              BottomNavigationBarItem(
                icon: USImageIcon(assetName: 'tab_attack'),
                label: Strings.attack.tr,
              ),
              BottomNavigationBarItem(
                icon: USImageIcon(assetName: 'tab_units'),
                label: Strings.my_forces.tr,
              ),
            ],
            currentIndex: controller.tabIndex,
            iconSize: 30,
            backgroundColor: Colors.transparent,
            selectedItemColor: USColors.navbarIconColor,
            onTap: controller.setIndex,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            elevation: 0,
            selectedLabelStyle: USText.BottomNavigationBarTextStyle,
            unselectedLabelStyle: USText.BottomNavigationBarTextStyle.copyWith(
                color: USColors.unselectedNavbarIconColor),
          ),
        )));
  }
}
