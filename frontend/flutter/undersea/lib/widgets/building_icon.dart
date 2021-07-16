import 'package:flutter/material.dart';
import 'package:undersea/core/theme/text_styles.dart';

import 'asset_icon.dart';

class BuildingIcon extends StatelessWidget {
  const BuildingIcon(
      {Key? key,
      required this.assetName,
      required this.amount,
      this.additional = '@3x'})
      : super(key: key);

  final String assetName;
  final int amount;
  final String additional;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            AssetIcon(iconName: assetName, isBuilding: true, iconSize: 50),
            Text(
              '$amount',
              style: USText.buttonTextStyle.copyWith(
                  color: Color(0xFF1C3E76),
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
            ),
          ],
        ));
  }
}
