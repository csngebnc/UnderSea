import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/user_data_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/styles/style_constants.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final controller = Get.find<UserDataController>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final citynameController = TextEditingController();
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    citynameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userField = UnderseaStyles.inputField(
        hint: Strings.username.tr, controller: usernameController);
    final passwordField = UnderseaStyles.inputField(
        hint: Strings.password.tr,
        isPassword: true,
        controller: passwordController);
    final passwordValidationField = UnderseaStyles.inputField(
        hint: Strings.password_again.tr,
        isPassword: true,
        controller: confirmPasswordController);
    final cityNameField = UnderseaStyles.inputField(
        hint: Strings.city_name_hint.tr, controller: citynameController);

    final registrationButton = UnderseaStyles.elevatedButton(
        text: Strings.registration.tr,
        onPressed: () {
          controller.register(
              username: usernameController.text,
              password: passwordController.text,
              confirmPassword: confirmPasswordController.text,
              countryName: citynameController.text,
              onSuccess: () {
                Get.back();
                UnderseaStyles.snackbar(
                  Strings.registr_snackbar_title.tr,
                  Strings.registr_snackbar_body.tr,
                );
              });
        });

    return Scaffold(
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
                SizedBox(height: 25),
                SizedBox(
                    height: 100,
                    child: UnderseaStyles.imageIcon("undersea_big",
                        color: UnderseaStyles.underseaLogoColor, size: 250)),
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white54,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: 30,
                              child: Text(
                                Strings.login.tr,
                                style: UnderseaStyles.buttonTextStyle
                                    .copyWith(fontSize: 24),
                              )),
                          SizedBox(height: 25.0),
                          userField,
                          SizedBox(height: 20.0),
                          passwordField,
                          SizedBox(
                            height: 20.0,
                          ),
                          passwordValidationField,
                          SizedBox(height: 20),
                          cityNameField,
                          SizedBox(height: 15),
                          registrationButton,
                          SizedBox(
                            height: 15.0,
                          ),
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(Strings.login.tr,
                                  style: UnderseaStyles.buttonTextStyle)),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ))));
  }
}
