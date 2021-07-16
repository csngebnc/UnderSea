import 'package:flutter/material.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:get/get.dart';
import 'package:undersea/core/theme/text_styles.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.hint,
      this.controller,
      this.isPassword = false,
      this.color = Colors.white,
      this.hintColor = USColors.hintColor,
      this.onChanged,
      this.validator = _defaultValidator})
      : super(key: key);

  final String hint;
  final TextEditingController? controller;
  final bool isPassword;
  final Color color;
  final Color hintColor;
  final void Function(String)? onChanged;
  final String? Function(String?) validator;

  static String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.empty_field.tr;
    }
    if (value.removeAllWhitespace != value) return Strings.invalid_username.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0), color: color),
      ),
      TextFormField(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: isPassword,
        style: USText.inputTextStyle,
        onChanged: onChanged,
        decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide:
                    BorderSide(color: USColors.navbarIconColor, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide:
                    BorderSide(color: USColors.underseaLogoColor, width: 2)),
            errorStyle:
                TextStyle(color: USColors.navbarIconColor, fontSize: 14),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: USColors.menuDarkBlue, width: 2)),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: hint,
            hintStyle: USText.hintStyle.copyWith(color: hintColor),
            border: InputBorder.none),
      )
    ]);
  }
}
