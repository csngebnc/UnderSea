import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/views/leaderboard.dart';

import 'disablable_elevated_button.dart';

class UnderseaStyles {
  static const TextStyle buttonTextStyle = TextStyle(
      fontFamily: 'Baloo 2',
      fontSize: 20.0,
      color: Color(0xFF001234),
      fontWeight: FontWeight.bold);
  static const TextStyle inputTextStyle =
      TextStyle(fontFamily: 'Open Sans', fontSize: 15);

  static final whiteOpenSans = UnderseaStyles.inputTextStyle
      .copyWith(color: Colors.white, fontWeight: FontWeight.normal);

  static const Color underseaLogoColor = Color(0xFF9FFFF0);
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
  static const menuDarkBlue = Color(0xFF03255F);
  static const LinearGradient buttonGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: gradientColors);
  static const shadowColor = Color(0xFF3B7DBD);
  static const hintColor = Color(0xFF1C3E76);
  static const alternativeHintColor = Color(0xFF001234);
  static const navbarIconColor = Color(0xFF001234);
  static const unselectedNavbarIconColor = Color(0x33001234);
  static const hintStyle =
      TextStyle(color: UnderseaStyles.hintColor, fontSize: 19);

  static void _defaultOnChanged(String s) {}

  static Widget inputField({
    required String hint,
    TextEditingController? controller,
    bool isPassword = false,
    Color color = Colors.white,
    Color hintColor = hintColor,
    void Function(String) onChanged = _defaultOnChanged,
  }) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0), color: color),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          style: UnderseaStyles.inputTextStyle,
          onChanged: onChanged,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: hint,
              hintStyle: UnderseaStyles.hintStyle.copyWith(color: hintColor),
              border: InputBorder.none),
        ));
  }

  static Widget infoPanel(
    String title,
    String hint, {
    EdgeInsets padding = const EdgeInsets.fromLTRB(20, 30, 0, 0),
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: padding,
            child: Text(title,
                style: UnderseaStyles.whiteOpenSans
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20))),
        if (hint.isNotEmpty)
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
            child: Text(hint,
                style: UnderseaStyles.whiteOpenSans.copyWith(fontSize: 20)),
          ),
      ],
    );
  }

  static Widget building(String name, {double? top, double? left}) {
    return Positioned(
        height: 180,
        top: top ?? 0,
        left: left ?? 0,
        child: UnderseaStyles.buildingImage(name, additional: "@3x"));
  }

  static Widget buildingImage(String name, {String additional = ''}) {
    return Image.asset('assets/buildings/$name$additional.png');
  }

  static Widget assetIcon(String iconName,
      {double iconSize = 40, bool isBuilding = false}) {
    return Container(
      decoration: isBuilding
          ? null
          : BoxDecoration(
              color: Color(0xFF9FFFF0),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xFF428DFF), width: 3.5)),
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

  static TextStyle listRegular = UnderseaStyles.whiteOpenSans
      .copyWith(fontWeight: FontWeight.normal, fontSize: 18, height: 1.5);
  static TextStyle listBold = UnderseaStyles.listRegular.copyWith(
    fontWeight: FontWeight.bold,
  );

  static Widget text(String text) {
    return Text(text, style: listRegular);
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

  static Widget circleButton(String iconName,
      {void Function()? onPressed = _emptyFunction}) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: UnderseaStyles.underseaLogoColor,
      child: UnderseaStyles.iconsFromImages(iconName),
      padding: EdgeInsets.all(5.0),
      shape: CircleBorder(),
    );
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
                  '$production/${Strings.round_resources.tr}',
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

  static Widget buildingIcon(String assetName, int amount,
      {String additional = '@3x'}) {
    return Container(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            UnderseaStyles.assetIcon(assetName, isBuilding: true, iconSize: 60),
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

  static Widget leaderboardButton(
      {required int roundNumber, required int placement}) {
    return ElevatedButton(
      onPressed: () {
        Get.to(Leaderboard());
      },
      child: SizedBox(
          width: 180,
          child: Padding(
              padding: EdgeInsets.fromLTRB(5, 7, 5, 5),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(children: [
                    _leaderboardText(roundNumber, Strings.round.tr),
                    _leaderboardText(placement, Strings.placement.tr),
                  ])))),
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.all(5),
          elevation: 10,
          shadowColor: UnderseaStyles.shadowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    );
  }

  static Widget _leaderboardText(int number, String text) {
    return Expanded(
        child: Align(
            alignment: Alignment.center,
            child: Text(
              number.toString() + text,
              style: UnderseaStyles.buttonTextStyle.copyWith(
                  color: UnderseaStyles.hintColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 22),
            )));
  }

  static Widget divider() {
    return Divider(
        color: Color(0xFF3F68AE),
        thickness: 2,
        indent: 20,
        endIndent: 20,
        height: 32);
  }

  static Widget elevatedButton(
      {required String text,
      required Function onPressed,
      double width = 250,
      double height = 70}) {
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
          width: width,
          height: height,
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

  static Widget appBarTitle(String text) {
    return Row(children: [
      SizedBox(
        width: 15,
      ),
      Text(
        text,
        style: UnderseaStyles.inputTextStyle.copyWith(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
      ),
    ]);
  }

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

  static Widget imageIcon(String name,
      {String additional = '@3x', Color? color, double? size}) {
    return ImageIcon(
      AssetImage(
        "assets/icons/$name$additional.png",
      ),
      color: color,
      size: size,
    );
  }

  static Widget iconsFromImages(String name, {double size = 35}) {
    return SizedBox(
        child: Image.asset(
          "assets/icons/$name@3x.png",
        ),
        height: size,
        width: size);
  }

  static void _emptyFunction() {}
  static Widget tabSkeleton(
      {required Widget list,
      String buttonText = Strings.buy_button,
      bool isDisabled = true,
      Function onButtonPressed = _emptyFunction}) {
    return Expanded(
        child: Stack(fit: StackFit.expand, children: [
      Container(
        decoration: BoxDecoration(color: UnderseaStyles.menuDarkBlue),
      ),
      list,
      Column(
        children: [
          Expanded(
            flex: 8,
            child: IgnorePointer(
                child: Container(
              decoration: BoxDecoration(color: Colors.transparent),
            )),
          ),
          Expanded(
              flex: 2,
              child: Container(
                  decoration: BoxDecoration(color: Colors.white54),
                  child: Align(
                      alignment: Alignment.center,
                      child: ToggleableElevatedButton(
                        text: buttonText.tr,
                        onPressed: onButtonPressed,
                        isDisabled: isDisabled,
                      ))))
        ],
      ),
    ]));
  }
}
