import 'package:flutter/material.dart';
import 'package:undersea/styles/style_constants.dart';

class ExpandedMenu extends StatelessWidget {
  ExpandedMenu();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UnderseaStyles.militaryIcon("shark", 0, 5),
          UnderseaStyles.militaryIcon("seal", 5, 10),
          UnderseaStyles.militaryIcon("seahorse", 5, 10),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnderseaStyles.resourceIcon("pearl", 230, 12),
          UnderseaStyles.resourceIcon("coral", 230, 12),
          UnderseaStyles.buildingIcon("zatonyvar@3x", 1),
          UnderseaStyles.buildingIcon("aramlasiranyito@3x", 0),
        ],
      )
    ]);
  }
}
