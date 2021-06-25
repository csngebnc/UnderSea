import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/expandable_menu.dart';

import 'leaderboard.dart';

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
          ElevatedButton(
            onPressed: () {
              Get.to(Leaderboard());
            },
            child: SizedBox(
                width: 180,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 5, 5),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(children: [
                          Expanded(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '4. kör',
                                    style: UnderseaStyles.buttonTextStyle
                                        .copyWith(
                                            color: Color(0xFF1C3E76),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 22),
                                  ))),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '23. hely',
                                    style: UnderseaStyles.buttonTextStyle
                                        .copyWith(
                                            color: Color(0xFF1C3E76),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 22),
                                  )))
                        ])))),
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.all(5),
                elevation: 10,
                shadowColor: UnderseaStyles.shadowColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          Expanded(child: Container()),
          ExpandableMenu(),
        ]));
  }
}
