import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/services/navbar_controller.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/attack_page.dart';
import 'package:undersea/views/city_tabs/city_tab_bar.dart';
import 'package:undersea/views/history_tabs/history_tab_bar.dart';
import 'package:undersea/views/profile.dart';
import 'home_page.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);
  final BottomNavBarController controller = Get.find<BottomNavBarController>();
  static final List<Widget> _appbarTitleOptions = <Widget>[
    SizedBox(
      height: 35,
      width: 100,
      child: UnderseaStyles.imageIcon("undersea_small",
          color: UnderseaStyles.underseaLogoColor),
    ),
    UnderseaStyles.appBarTitle(Strings.my_city.tr),
    UnderseaStyles.appBarTitle(Strings.attack.tr),
    UnderseaStyles.appBarTitle(Strings.my_forces.tr),
  ];
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CityTabBar(),
    AttackPage(),
    HistoryTabBar(() {})
  ];

  void _onItemTapped(int index) {
    controller.selectedTab.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          toolbarHeight: controller.selectedTab.value == 0 ? 85 : 60,
          backgroundColor: UnderseaStyles.hintColor,
          actions: [
            if (controller.selectedTab.value == 0)
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(ProfilePage());
                      },
                      child: SizedBox(
                          height: 40,
                          child: UnderseaStyles.assetIcon("profile",
                              iconSize: 42))))
          ],
          title: _appbarTitleOptions.elementAt(controller.selectedTab.value),
        ),
        body: Center(
          child: _widgetOptions.elementAt(controller.selectedTab.value),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: UnderseaStyles.gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: UnderseaStyles.imageIcon('tab_home'),
                label: Strings.home_page.tr,
              ),
              BottomNavigationBarItem(
                icon: UnderseaStyles.imageIcon('tab_city'),
                label: Strings.my_city.tr,
              ),
              BottomNavigationBarItem(
                icon: UnderseaStyles.imageIcon('tab_attack'),
                label: Strings.attack.tr,
              ),
              BottomNavigationBarItem(
                icon: UnderseaStyles.imageIcon('tab_units'),
                label: Strings.my_forces.tr,
              ),
            ],
            currentIndex: controller.selectedTab.value,
            iconSize: 30,
            backgroundColor: Colors.transparent,
            selectedItemColor: UnderseaStyles.navbarIconColor,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            elevation: 0,
            selectedLabelStyle: UnderseaStyles.bottomNavbarTextStyle,
            unselectedLabelStyle: UnderseaStyles.bottomNavbarTextStyle
                .copyWith(color: UnderseaStyles.unselectedNavbarIconColor),
          ),
        )));
  }
}
