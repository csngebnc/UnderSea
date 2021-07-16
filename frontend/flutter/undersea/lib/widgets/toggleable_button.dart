import 'package:flutter/material.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';

class ToggleableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isDisabled;
  ToggleableButton(
      {required this.text, required this.onPressed, required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 10,
          shadowColor: USColors.shadowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(200))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: isDisabled
                ? USColors.opaqueButtonGradient
                : USColors.buttonGradient,
            borderRadius: BorderRadius.circular(200)),
        child: Container(
          width: 200,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            text,
            style: USText.buttonTextStyle.copyWith(fontSize: 19),
          ),
        ),
      ),
    );
  }
}
