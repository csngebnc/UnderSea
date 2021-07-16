import 'package:flutter/material.dart';
import 'package:undersea/core/theme/colors.dart';

class USText {
  static const TextStyle buttonTextStyle = TextStyle(
      fontFamily: 'Baloo 2',
      fontSize: 20.0,
      color: USColors.navbarIconColor,
      fontWeight: FontWeight.bold);
  static const TextStyle inputTextStyle =
      TextStyle(fontFamily: 'Open Sans', fontSize: 15);

  static final whiteOpenSans = inputTextStyle.copyWith(
      color: Colors.white, fontWeight: FontWeight.normal);

  static const hintStyle = TextStyle(color: USColors.hintColor, fontSize: 15);

  static TextStyle listRegular = whiteOpenSans.copyWith(
      fontWeight: FontWeight.normal, fontSize: 14, height: 1.5);
  static TextStyle listBold = listRegular.copyWith(
    fontWeight: FontWeight.bold,
  );

  static const bottomNavbarTextStyle = TextStyle(
      color: USColors.navbarIconColor,
      fontFamily: 'Baloo 2',
      fontSize: 11,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold);

  static Widget text(String text) {
    return Text(text, style: listRegular);
  }
}
