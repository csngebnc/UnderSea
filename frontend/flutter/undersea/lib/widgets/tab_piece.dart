import 'package:flutter/material.dart';
import 'package:undersea/core/theme/text_styles.dart';

class TabPiece extends StatelessWidget {
  const TabPiece(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Text(
          text,
          style: USText.inputTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}
