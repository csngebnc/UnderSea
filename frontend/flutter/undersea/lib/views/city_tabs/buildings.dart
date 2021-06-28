import 'package:flutter/material.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:get/get.dart';

class Buildings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnderseaStyles.tabSkeleton(
        list: ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int i) {
              if (i == 0)
                return UnderseaStyles.infoPanel(
                    Strings.buildings_manual_title.tr,
                    Strings.buildings_manual_hint.tr);

              return _buildRow(i);
            }));
  }

  Widget _buildRow(int index) {
    return ListTile(
      title: Text(index.toString()),
    );
  }
}
