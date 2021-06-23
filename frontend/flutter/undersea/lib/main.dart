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
                title: Text("expansion cucli"),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blueAccent),
            label: 'Kezdőlap',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business, color: Colors.blueAccent),
            label: 'Városom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: Colors.blueAccent),
            label: 'Támadás',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: Colors.blueAccent),
            label: 'Csapataim',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
