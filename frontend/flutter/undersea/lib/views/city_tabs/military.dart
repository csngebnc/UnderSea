import 'package:flutter/material.dart';
import 'package:undersea/styles/disablable_elevated_button.dart';
import 'package:undersea/styles/style_constants.dart';

class Military extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var button = ToggleableElevatedButton(text: "Megveszem", onPressed: () {});

    return Expanded(
        child: Stack(fit: StackFit.expand, children: [
      Container(
        decoration: BoxDecoration(color: UnderseaStyles.menuDarkBlue),
      ),
      Column(
        children: [
          Expanded(
              flex: 8,
              child: Container(
                  //decoration: BoxDecoration(color: Colors.amberAccent),
                  )),
          Expanded(
              flex: 2,
              child: Container(
                  decoration: BoxDecoration(color: Colors.white54),
                  child: Align(
                      alignment: Alignment.center,
                      child:
                          /*UnderseaStyles.elevatedButton(
                        text: "Megveszem", onPressed: () {}),*/
                          button)))
        ],
      ),
    ]));
  }
}
