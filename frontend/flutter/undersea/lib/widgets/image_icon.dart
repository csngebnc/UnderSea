import 'package:flutter/material.dart';

class USImageIcon extends StatelessWidget {
  const USImageIcon(
      {Key? key,
      required this.assetName,
      this.additional = '@3x',
      this.color,
      this.size})
      : super(key: key);

  final String assetName;
  final String additional;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(
        "assets/icons/$assetName$additional.png",
      ),
      color: color,
      size: size,
    );
  }
}
