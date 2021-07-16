import 'package:flutter/material.dart';
import 'package:undersea/core/theme/text_styles.dart';

class ListInfoPanel extends StatelessWidget {
  const ListInfoPanel(
      {Key? key,
      required this.title,
      required this.hint,
      this.padding = const EdgeInsets.fromLTRB(20, 30, 0, 0)})
      : super(key: key);

  final String title;
  final String hint;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: padding,
            child: Text(title,
                style: USText.whiteOpenSans
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 16))),
        if (hint.isNotEmpty)
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
            child:
                Text(hint, style: USText.whiteOpenSans.copyWith(fontSize: 16)),
          ),
      ],
    );
  }
}
