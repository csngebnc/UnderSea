import 'package:flutter/material.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/expandable_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background/main bg4@3x.png'),
              fit: BoxFit.cover),
        ),
        child: Column(children: [
          SizedBox(height: 10),
          UnderseaStyles.leaderboardButton(roundNumber: 4, placement: 23),
          Expanded(child: Container()),
          ExpandableMenu(),
        ]));
  }
}
