import 'package:flutter/material.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';
import 'package:undersea/widgets/asset_icon.dart';
import 'package:get/get.dart';

class ResourceIcon extends StatelessWidget {
  const ResourceIcon(
      {Key? key,
      required this.assetName,
      required this.currentAmount,
      required this.productionPerRound})
      : super(key: key);
  final String assetName;
  final int currentAmount;
  final int productionPerRound;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            AssetIcon(iconName: assetName),
            Column(
              children: [
                Text(
                  '$currentAmount',
                  style: USText.buttonTextStyle.copyWith(
                      color: USColors.hintColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      height: 1.2),
                ),
                Text(
                  '$productionPerRound/${Strings.round_resources.tr}',
                  style: USText.buttonTextStyle.copyWith(
                      color: USColors.hintColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      height: 1.1),
                )
              ],
            )
          ],
        ));
  }
}
