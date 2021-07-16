import 'package:flutter/material.dart';

class BuildingImage extends StatelessWidget {
  const BuildingImage({Key? key, required this.name, this.additional = ''})
      : super(key: key);

  final String name;
  final String additional;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/buildings/$name$additional.png',
    );
  }
}
