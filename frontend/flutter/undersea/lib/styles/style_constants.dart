import 'package:flutter/material.dart';

class UnderseaStyles {
  static const TextStyle buttonTextStyle = TextStyle(
      fontFamily: 'Baloo 2',
      fontSize: 20.0,
      color: Color(0xFF001234),
      fontWeight: FontWeight.bold);
  static const TextStyle inputTextStyle =
      TextStyle(fontFamily: 'Open Sans', fontSize: 15);

  static const Color underseaLogoColor = Color(0xFF9FFFF0);
  static const gradientColors = [
    Color(0xff9FFFF0),
    Color(0xff6BEEE9),
    Color(0xff0FCFDE)
  ];

  static const LinearGradient buttonGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: gradientColors);
  static const shadowColor = Color(0xFF3B7DBD);
  static const hintColor = Color(0xFF1C3E76);
  static const navbarIconColor = Color(0xff001234);
  static const unselectedNavbarIconColor = Color(0x99001234);
  static const hintStyle =
      TextStyle(color: UnderseaStyles.hintColor, fontSize: 19);

  static Widget inputField({required String hint, bool isPassword = false}) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0), color: Colors.white),
        child: TextField(
          obscureText: isPassword,
          style: UnderseaStyles.inputTextStyle,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: hint,
              hintStyle: UnderseaStyles.hintStyle,
              border: InputBorder.none),
        ));
  }

  static Widget elevatedButton(
      {required String text, required Function onPressed}) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 10,
          shadowColor: Color(0xFF3B7DBD),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(200))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: buttonGradient, borderRadius: BorderRadius.circular(200)),
        child: Container(
          width: 250,
          height: 70,
          alignment: Alignment.center,
          child: Text(
            text,
            style: buttonTextStyle.copyWith(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
