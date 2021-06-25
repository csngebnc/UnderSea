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
        //extendBody: true,
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor: Color(0xFF1C3E76),
          actions: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: GestureDetector(
                    onTap: () {
                      Get.to(ProfilePage(
                          cityName: 'Óceánia', playerName: 'jakabjatekos'));
                    },
                    child: SizedBox(
                        height: 40,
                        child:
                            UnderseaStyles.assetIcon("profile", iconSize: 40))))
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
            child: Theme(
              data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                primaryColor: Colors.green,
              ),
              child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Kezdőlap',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.business,
                      ),
                      label: 'Városom',
                      backgroundColor: Colors.transparent),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.school,
                    ),
                    label: 'Támadás',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.school,
                    ),
                    label: 'Csapataim',
                  ),
                ],
                currentIndex: _selectedIndex,
                iconSize: 30,
                selectedItemColor: UnderseaStyles.navbarIconColor,
                onTap: _onItemTapped,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                backgroundColor: Color(0x00000000),
                elevation: 0,
                selectedLabelStyle: UnderseaStyles.bottomNavbarTextStyle,
                unselectedLabelStyle: UnderseaStyles.bottomNavbarTextStyle
                    .copyWith(color: UnderseaStyles.unselectedNavbarIconColor),
              ),
            )));
  }
}
