import 'package:flutter/material.dart';

class USColors {
  static const underseaLogoColor = Color(0xFF9FFFF0);
  static const menuDarkBlue = Color(0xFF03255F);
  static const shadowColor = Color(0xFF3B7DBD);
  static const hintColor = Color(0xFF1C3E76);
  static const alternativeHintColor = Color(0xFF001234);
  static const navbarIconColor = Color(0xFF001234);
  static const unselectedNavbarIconColor = Color(0x33001234);
  static const borderColor = Color(0xFF428DFF);
  static const dividerColor = Color(0xFF3F68AE);

  static const gradientColors = [
    Color(0xff9FFFF0),
    Color(0xff6BEEE9),
    Color(0xff0FCFDE)
  ];

  static const opaqueGradientColors = [
    Color(0x449FFFF0),
    Color(0x446BEEE9),
    Color(0x440FCFDE)
  ];

  static const LinearGradient buttonGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: gradientColors);

  static const LinearGradient opaqueButtonGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: opaqueGradientColors);
}
