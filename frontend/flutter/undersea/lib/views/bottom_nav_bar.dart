import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/attack_page.dart';
import 'package:undersea/views/city_tabs/city_tab_controller.dart';
import 'package:undersea/views/my_army.dart';
import 'package:undersea/views/profile.dart';
import 'home_page.dart';

/// This is the stateful widget that the main application instantiates.
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static List<Widget> _appbarTitleOptions = <Widget>[
    // UnderseaStyles.appBarTitle(Strings.undersea.tr),
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
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CityTabBar(),
    AttackPage(),
    MyArmyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBody: true,
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor: UnderseaStyles.hintColor,
          actions: [
            if (_selectedIndex == 0)
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(ProfilePage(
                            cityName: 'Óceánia', playerName: 'jakabjatekos'));
                      },
                      child: SizedBox(
                          height: 40,
                          child: UnderseaStyles.assetIcon("profile",
                              iconSize: 42))))
          ],
          title: _appbarTitleOptions.elementAt(_selectedIndex),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: UnderseaStyles.gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              //tileMode: TileMode.,
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
            currentIndex: _selectedIndex,
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
        ));
  }
}
