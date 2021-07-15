import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/user_data_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/styles/disablable_elevated_button.dart';
import 'package:undersea/views/registration.dart';
import 'package:undersea/styles/style_constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var hasError = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userField = UnderseaStyles.inputField(
        hint: Strings.username.tr,
        controller: usernameController,
        onChanged: (string) {
          /*setState(() {
            hasError = !_formKey.currentState!.validate();
          });*/
        });
    final passwordField = UnderseaStyles.inputField(
        hint: Strings.password.tr,
        isPassword: true,
        controller: passwordController,
        onChanged: (string) {
          /*setState(() {
            hasError = !_formKey.currentState!.validate();
          });*/
        });
    final UserDataController controller = Get.find();

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
                        child: UnderseaStyles.imageIcon("undersea_big",
                            color: UnderseaStyles.underseaLogoColor,
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
                                    style: UnderseaStyles.buttonTextStyle
                                        .copyWith(fontSize: 24),
                                  )),
                              GetBuilder<UserDataController>(
                                  builder: (controller) {
                                return controller.loggingIn.value
                                    ? Center(
                                        child: Column(
                                        children: [
                                          SizedBox(height: 30.0),
                                          SizedBox(
                                              height: 75,
                                              width: 75,
                                              child:
                                                  CircularProgressIndicator()),
                                          SizedBox(height: 50),
                                        ],
                                      ))
                                    : Column(children: [
                                        SizedBox(height: 30.0),
                                        userField,
                                        SizedBox(height: 25.0),
                                        passwordField
                                      ]);
                              }),
                              SizedBox(
                                height: 35.0,
                              ),
                              ToggleableElevatedButton(
                                  text: Strings.login.tr,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.login(usernameController.text,
                                          passwordController.text);
                                    }
                                  },
                                  isDisabled: hasError),
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
                )))));
  }
}
