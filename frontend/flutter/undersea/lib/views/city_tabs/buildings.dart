import 'package:flutter/material.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:get/get.dart';

class Buildings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnderseaStyles.cityTabSkeleton(
        list: ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int i) {
              if (i == 0) return _infoPanel();

              return _buildRow(i);
            }));
  }

  Widget _buildRow(int index) {
    return ListTile(
      title: Text(index.toString()),
    );
  }

  Widget _infoPanel() {
    return Column(
      children: [
        Text(Strings.buildings_manual_title.tr),
        Text(Strings.buildings_manual_hint.tr),
      ],
    );
  }
}
