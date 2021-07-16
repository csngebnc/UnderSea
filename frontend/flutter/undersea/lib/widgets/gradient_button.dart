import 'package:flutter/material.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';

class GradientButton extends StatelessWidget {
  const GradientButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.width = 200,
      this.height = 55})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 10,
          shadowColor: USColors.shadowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(200))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: USColors.buttonGradient,
            borderRadius: BorderRadius.circular(200)),
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Text(
            text,
            style: USText.buttonTextStyle.copyWith(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
