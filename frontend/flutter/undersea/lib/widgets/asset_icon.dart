import 'package:flutter/material.dart';
import 'package:undersea/core/theme/colors.dart';

class AssetIcon extends StatelessWidget {
  const AssetIcon(
      {Key? key,
      required this.iconName,
      this.iconSize = 30,
      this.isBuilding = false})
      : super(key: key);

  final String iconName;
  final double iconSize;
  final bool isBuilding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isBuilding
          ? null
          : BoxDecoration(
              color: USColors.underseaLogoColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: USColors.borderColor, width: 3.5)),
      child: Padding(
        padding: EdgeInsets.all(isBuilding ? 0 : 8),
        child: Container(
          child: SizedBox(height: iconSize, width: iconSize),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/icons/$iconName.png'),
                fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
