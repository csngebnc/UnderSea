import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/login_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/views/registration.dart';
import 'bottom_nav_bar.dart';
import 'package:undersea/styles/style_constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
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
    final LoginController controller = Get.find();
    final loginButton = UnderseaStyles.elevatedButton(
        text: Strings.login.tr,
        onPressed: () {
          if (usernameController.text.isEmpty ||
              passwordController.text.isEmpty) return;
          controller.login(usernameController.text, passwordController.text);
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
                SizedBox(height: 10),
                SizedBox(
                    height: 100,
                    child: UnderseaStyles.imageIcon("undersea_big",
                        color: UnderseaStyles.underseaLogoColor, size: 250)),
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
                                style: UnderseaStyles.buttonTextStyle
                                    .copyWith(fontSize: 24),
                              )),
                          SizedBox(height: 30.0),
                          userField,
                          SizedBox(height: 25.0),
                          passwordField,
                          SizedBox(
                            height: 35.0,
                          ),
                          loginButton,
                          SizedBox(
                            height: 15.0,
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(RegistrationPage());
                              },
                              child: Text(Strings.registration.tr,
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
