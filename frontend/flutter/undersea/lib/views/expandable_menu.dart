import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:undersea/styles/style_constants.dart';

import 'expanded_menu.dart';

class ExpandableMenu extends StatefulWidget {
  ExpandableMenu();
  @override
  _ExpandableMenuState createState() => _ExpandableMenuState();
}

class _ExpandableMenuState extends State<ExpandableMenu> {
  var isExpanded = false;
  final _controller = ExpandableController(initialExpanded: false);

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        isExpanded = _controller.value;
      });
    });
    return ExpandableNotifier(
      controller: _controller,
      child: Column(
        children: [
          ExpandablePanel(
            header: Container(
              padding: EdgeInsets.zero,
              child: isExpanded
                  ? UnderseaStyles.imageIcon('caret_down', size: 30)
                  : UnderseaStyles.imageIcon('caret_up', size: 30),
              decoration: BoxDecoration(color: Colors.white),
            ),
            theme: ExpandableThemeData(
              hasIcon: false,
              tapHeaderToExpand: true,
              useInkWell: true,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
            ),
            collapsed: ExpandableButton(child: Container()),
            expanded: Column(children: [
              ExpandableButton(
                  child: Container(
                decoration: BoxDecoration(color: Colors.white54),
                child: ExpandedMenu(),
              )),
            ]),
          ),
        ],
      ),
    );
  }
}
