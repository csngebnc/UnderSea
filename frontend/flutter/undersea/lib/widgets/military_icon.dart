import 'package:flutter/material.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';

import 'asset_icon.dart';

class MilitaryIcon extends StatelessWidget {
  const MilitaryIcon(
      {Key? key,
      required this.assetName,
      required this.current,
      required this.max})
      : super(key: key);

  final String assetName;
  final int current;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(6),
        child: Column(
          children: [
            AssetIcon(iconName: assetName),
            Text(
              '$current/$max',
              style: USText.buttonTextStyle.copyWith(
                  color: USColors.hintColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
            )
          ],
        ));
  }
}
