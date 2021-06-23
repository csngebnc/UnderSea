import 'package:flutter/material.dart';

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
              child: TabBar(
                tabs: [
                  Text(
                    'Épületek',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Fejlesztések",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Sereg",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          //title: Text('Tabs Demo'),

          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
