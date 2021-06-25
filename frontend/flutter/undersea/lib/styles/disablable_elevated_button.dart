import 'package:flutter/material.dart';
import 'package:undersea/styles/style_constants.dart';

class ToggleableElevatedButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  ToggleableElevatedButton({required this.text, required this.onPressed});
  @override
  _ToggleableElevatedButtonState createState() =>
      new _ToggleableElevatedButtonState();
}

class _ToggleableElevatedButtonState extends State<ToggleableElevatedButton> {
  var _isDisabled = true;

  @override
  void initState() {
    //_isDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _isDisabled ? null : widget.onPressed();
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 10,
          shadowColor: Color(0xFF3B7DBD),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(200))),
      child: Ink(
        decoration: BoxDecoration(
            color: _isDisabled ? Colors.white10 : Colors.transparent,
            gradient: UnderseaStyles.buttonGradient,
            borderRadius: BorderRadius.circular(200)),
        child: Container(
          width: 250,
          height: 70,
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: UnderseaStyles.buttonTextStyle.copyWith(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
