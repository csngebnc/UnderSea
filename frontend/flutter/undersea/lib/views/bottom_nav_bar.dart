import 'package:flutter/material.dart';
import 'package:undersea/views/city_tabs/city_tab_controller.dart';
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
          title: const Text('Undersea ~~~~~'),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff9FFFF0), Color(0xff6BEEE9), Color(0xff0FCFDE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              //tileMode: TileMode.,
            ),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Color(0xff001234)),
                label: 'Kezdőlap',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business, color: Color(0xff001234)),
                label: 'Városom',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school, color: Color(0xff001234)),
                label: 'Támadás',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school, color: Color(0xff001234)),
                label: 'Csapataim',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xff001234),
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            backgroundColor: Colors.transparent,
            selectedLabelStyle: TextStyle(
                color: Color(0xff001234),
                fontFamily: 'Baloo 2',
                fontSize: 11,
                fontStyle: FontStyle.normal),
            unselectedLabelStyle: TextStyle(
                color: Color(0xff001234),
                fontFamily: 'Baloo 2',
                fontSize: 11,
                fontStyle: FontStyle.normal),
          ),
        ));
  }
}
