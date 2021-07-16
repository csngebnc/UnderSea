import 'package:flutter/material.dart';
import 'package:undersea/core/theme/colors.dart';

class USDivider extends StatelessWidget {
  const USDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
        color: USColors.dividerColor,
        thickness: 2,
        indent: 20,
        endIndent: 20,
        height: 32);
  }
}
