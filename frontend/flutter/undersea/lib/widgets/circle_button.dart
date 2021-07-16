import 'package:flutter/material.dart';
import 'package:undersea/core/theme/colors.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({Key? key, required this.iconName, this.onPressed})
      : super(key: key);

  final String iconName;
  final VoidCallback? onPressed;

  static Widget iconsFromImages(String name, {double size = 35}) {
    return SizedBox(
        child: Image.asset(
          "assets/icons/$name@3x.png",
        ),
        height: size,
        width: size);
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed?.call,
      elevation: 2.0,
      fillColor: USColors.underseaLogoColor,
      child: iconsFromImages(iconName),
      padding: EdgeInsets.all(2.0),
      shape: CircleBorder(),
    );
  }
}
