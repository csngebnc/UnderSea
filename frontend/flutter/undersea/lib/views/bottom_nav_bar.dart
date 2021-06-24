import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/city_tabs/city_tab_controller.dart';
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
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CityTabBar(),
    Text('Index 2: Támadás'),
    Text('Index 3: Csapataim'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1C3E76),
          actions: [
            Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                    onTap: () {
                      Get.to(ProfilePage(
                          cityName: 'Óceánia', playerName: 'jakabjatekos'));
                    },
                    child: Image.asset('assets/buildings/seastar.png')))
          ],
          title: const Text('Undersea logo'),
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: UnderseaStyles.navbarIconColor),
                label: 'Kezdőlap',
              ),
              BottomNavigationBarItem(
                icon:
                    Icon(Icons.business, color: UnderseaStyles.navbarIconColor),
                label: 'Városom',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school, color: UnderseaStyles.navbarIconColor),
                label: 'Támadás',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school, color: UnderseaStyles.navbarIconColor),
                label: 'Csapataim',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: UnderseaStyles.navbarIconColor,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            backgroundColor: Colors.transparent,
            selectedLabelStyle: TextStyle(
                color: UnderseaStyles.navbarIconColor,
                fontFamily: 'Baloo 2',
                fontSize: 11,
                fontStyle: FontStyle.normal),
            unselectedLabelStyle: TextStyle(
                color: UnderseaStyles.unselectedNavbarIconColor,
                fontFamily: 'Baloo 2',
                fontSize: 11,
                fontStyle: FontStyle.normal),
          ),
        ));
  }
}
