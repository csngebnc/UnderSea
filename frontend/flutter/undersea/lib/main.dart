import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/views/city_tabs/city_tab_controller.dart';
import 'views/my_home_page.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/background/main bg4@3x.png',
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
              ),
              fit: BoxFit.cover),
        ),
        child: Column(children: [
          Expanded(
            child: Text(
              'Index 0: Kezdőlap',
              style: optionStyle,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ExpansionTile(
                title: Center(child: Icon(Icons.expand_less)),
                backgroundColor: Colors.white38,
                iconColor: Colors.black,
                trailing: null,
                collapsedBackgroundColor: Colors.white,
                expandedAlignment: Alignment.topCenter,
                children: [
                  Icon(Icons.ac_unit),
                  Icon(Icons.ac_unit),
                  Icon(Icons.ac_unit),
                  Icon(Icons.ac_unit)
                ],
              ),
            ),
          )
        ])),
    CityTabBar(),
    Text(
      'Index 2: Támadás',
      style: optionStyle,
    ),
    Text(
      'Index 3: Csapataim',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.transparent,
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
