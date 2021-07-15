import 'package:flutter/material.dart';
import 'package:undersea/styles/style_constants.dart';

class ToggleableElevatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isDisabled;
  ToggleableElevatedButton(
      {required this.text, required this.onPressed, required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (isDisabled) {
          () {};
        } else {
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 10,
          shadowColor: UnderseaStyles.shadowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(200))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: isDisabled
                ? LinearGradient(colors: UnderseaStyles.opaqueGradientColors)
                : UnderseaStyles.buttonGradient,
            borderRadius: BorderRadius.circular(200)),
        child: Container(
          width: 200,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            text,
            style: UnderseaStyles.buttonTextStyle.copyWith(fontSize: 19),
          ),
        ),
      ),
    );
  }
}
