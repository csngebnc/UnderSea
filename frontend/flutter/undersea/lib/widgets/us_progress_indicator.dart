import 'package:flutter/material.dart';
import 'package:undersea/core/theme/colors.dart';

class USProgressIndicator extends StatelessWidget {
  const USProgressIndicator({Key? key, this.size = 50, this.padding = 30})
      : super(key: key);

  final double size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SizedBox(
            height: size,
            width: size,
            child:
                CircularProgressIndicator(color: USColors.underseaLogoColor)),
      ),
    );
    ;
  }
}
