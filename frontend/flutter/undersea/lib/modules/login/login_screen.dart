import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';
import 'package:undersea/services/user_service.dart';
import 'package:undersea/modules/registration.dart';
import 'package:undersea/widgets/image_icon.dart';
import 'package:undersea/widgets/input_field.dart';
import 'package:undersea/widgets/toggleable_button.dart';

import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  static const routeName = 'login';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      var userField = InputField(
        hint: Strings.username.tr,
        controller: controller.usernameController,
      );
      final passwordField = InputField(
        hint: Strings.password.tr,
        isPassword: true,
        controller: controller.passwordController,
      );

      return Form(
          key: _formKey,
          child: Scaffold(
              body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/background/sign in bg@3x.png',
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                      child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(height: 10),
                      SizedBox(
                          height: 100,
                          child: USImageIcon(
                              assetName: "undersea_big",
                              color: USColors.underseaLogoColor,
                              size: 250)),
                      SizedBox(height: 25),
                      Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white54,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 15),
                                SizedBox(
                                    height: 30,
                                    child: Text(
                                      Strings.login.tr,
                                      style: USText.buttonTextStyle
                                          .copyWith(fontSize: 24),
                                    )),
                                controller.obx(
                                  (state) => Column(children: [
                                    SizedBox(height: 30.0),
                                    userField,
                                    SizedBox(height: 25.0),
                                    passwordField
                                  ]),
                                  onLoading: Center(
                                      child: Column(
                                    children: [
                                      SizedBox(height: 30.0),
                                      SizedBox(
                                          height: 75,
                                          width: 75,
                                          child: CircularProgressIndicator()),
                                      SizedBox(height: 50),
                                    ],
                                  )),
                                  onEmpty: Column(children: [
                                    SizedBox(height: 30.0),
                                    userField,
                                    SizedBox(height: 25.0),
                                    passwordField
                                  ]),
                                ),
                                SizedBox(
                                  height: 35.0,
                                ),
                                ToggleableButton(
                                  text: Strings.login.tr,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.login();
                                    }
                                  },
                                  isDisabled: false,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(RegistrationPage());
                                    },
                                    child: Text(Strings.registration.tr,
                                        style: USText.buttonTextStyle)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )))));
    });
  }
}
