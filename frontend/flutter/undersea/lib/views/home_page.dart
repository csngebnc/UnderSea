import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text('Index 0: Kezdőlap'),
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
        ]));
  }
}
