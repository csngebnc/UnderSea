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
  static const menuDarkBlue = Color(0xFF03255F);
  static const LinearGradient buttonGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: gradientColors);
  static const shadowColor = Color(0xFF3B7DBD);
  static const hintColor = Color(0xFF1C3E76);
  static const navbarIconColor = Color(0xFF001234);
  static const unselectedNavbarIconColor = Color(0x33001234);
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

  static Widget assetIcon(
    String iconName, {
    double iconSize = 40,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF9FFFF0),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xFF428DFF), width: 3)),
      child: Padding(
        padding: EdgeInsets.all(8),
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

  static Widget militaryIcon(String assetName, int current, int max) {
    return Container(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            UnderseaStyles.assetIcon(assetName),
            Text(
              '$current/$max',
              style: UnderseaStyles.buttonTextStyle.copyWith(
                  color: Color(0xFF1C3E76),
                  fontWeight: FontWeight.w800,
                  fontSize: 22),
            )
          ],
        ));
  }

  static Widget resourceIcon(String assetName, int current, int production) {
    return Container(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            UnderseaStyles.assetIcon(assetName),
            Column(
              children: [
                Text(
                  '$current',
                  style: UnderseaStyles.buttonTextStyle.copyWith(
                      color: Color(0xFF1C3E76),
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      height: 1.2),
                ),
                Text(
                  '$production/kör',
                  style: UnderseaStyles.buttonTextStyle.copyWith(
                      color: Color(0xFF1C3E76),
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      height: 1.1),
                )
              ],
            )
          ],
        ));
  }

  static Widget buildingIcon(String assetName, int amount) {
    return Container(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            UnderseaStyles.assetIcon(assetName),
            Text(
              '$amount',
              style: UnderseaStyles.buttonTextStyle.copyWith(
                  color: Color(0xFF1C3E76),
                  fontWeight: FontWeight.w800,
                  fontSize: 22),
            ),
          ],
        ));
  }

  static divider() {
    return Divider(
        color: Color(0xFF3F68AE),
        thickness: 2,
        indent: 20,
        endIndent: 20,
        height: 32);
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

  static const bottomNavbarTextStyle = TextStyle(
      color: UnderseaStyles.navbarIconColor,
      fontFamily: 'Baloo 2',
      fontSize: 15,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold);

  static Widget tab(String text) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Text(
          text,
          style: UnderseaStyles.inputTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    );
  }
}
