import 'package:flutter/material.dart';
import 'package:undersea/core/theme/text_styles.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 15,
      ),
      Text(
        text,
        style: USText.inputTextStyle.copyWith(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
      ),
    ]);
  }
}
