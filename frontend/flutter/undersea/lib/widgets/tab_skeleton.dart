import 'package:flutter/material.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:get/get.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/widgets/toggleable_button.dart';

class TabSkeleton extends StatelessWidget {
  const TabSkeleton(
      {Key? key,
      this.buttonText = Strings.buy_button,
      this.isDisabled = true,
      required this.onButtonPressed,
      required this.list})
      : super(key: key);

  final Widget list;
  final String buttonText;
  final bool isDisabled;
  final void Function() onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(fit: StackFit.expand, children: [
      Container(
        decoration: BoxDecoration(color: USColors.menuDarkBlue),
      ),
      list,
      Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Expanded(
              child: IgnorePointer(
                  child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
              )),
            ),
            Container(
                decoration: BoxDecoration(color: Colors.white54),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                        alignment: Alignment.center,
                        child: ToggleableButton(
                          text: buttonText.tr,
                          onPressed: onButtonPressed,
                          isDisabled: isDisabled,
                        ))))
          ],
        ),
      )
    ]));
  }
}
