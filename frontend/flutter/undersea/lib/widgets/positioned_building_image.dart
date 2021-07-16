import 'package:flutter/material.dart';

import 'building_image.dart';

class PositionedBuildingImage extends StatelessWidget {
  const PositionedBuildingImage(
      {Key? key, required this.name, this.top = 0, this.left = 0})
      : super(key: key);

  final String name;
  final double top;
  final double left;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        height: 140,
        top: top,
        left: left,
        child: BuildingImage(
            name: name, additional: name == 'stone_mine' ? '' : "@3x"));
  }
}
