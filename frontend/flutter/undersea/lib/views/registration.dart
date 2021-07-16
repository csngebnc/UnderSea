import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/services/user_service.dart';
import 'package:undersea/styles/disablable_elevated_button.dart';
import 'package:undersea/styles/style_constants.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final controller = Get.find<UserService>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final citynameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var hasError = false;
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
      hint: Strings.username.tr,
      controller: usernameController,
      onChanged: (string) {
        /*setState(() {
          hasError = !_formKey.currentState!.validate();
        });*/
      },
    );
    final passwordField = UnderseaStyles.inputField(
        hint: Strings.password.tr,
        isPassword: true,
        controller: passwordController,
        onChanged: (string) {
          /* setState(() {
            hasError = !_formKey.currentState!.validate();
          });*/
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return Strings.empty_field.tr;
          }
          if (value.removeAllWhitespace != value) {
            return Strings.invalid_username.tr;
          }
          if (confirmPasswordController.text != passwordController.text) {
            return Strings.passwords_differ.tr;
          }
        });
    final passwordValidationField = UnderseaStyles.inputField(
        hint: Strings.password_again.tr,
        isPassword: true,
        controller: confirmPasswordController,
        onChanged: (string) {
          /*setState(() {
            hasError = !_formKey.currentState!.validate();
          });*/
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return Strings.empty_field.tr;
          }
          if (value.removeAllWhitespace != value) {
            return Strings.invalid_username.tr;
          }
          if (confirmPasswordController.text != passwordController.text) {
            return Strings.passwords_differ.tr;
          }
        });
    final cityNameField = UnderseaStyles.inputField(
        hint: Strings.city_name_hint.tr,
        controller: citynameController,
        onChanged: (string) {
          /* setState(() {
            hasError = !_formKey.currentState!.validate();
          });*/
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return Strings.empty_field.tr;
          }
        });

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
                    SizedBox(height: 25),
                    SizedBox(
                        height: 100,
                        child: UnderseaStyles.imageIcon("undersea_big",
                            color: UnderseaStyles.underseaLogoColor,
                            size: 250)),
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
                              GetBuilder<UserService>(builder: (controller) {
                                return controller.regging.value
                                    ? Center(
                                        child: Column(
                                        children: [
                                          SizedBox(height: 75.0),
                                          SizedBox(
                                              height: 75,
                                              width: 75,
                                              child:
                                                  CircularProgressIndicator()),
                                          SizedBox(height: 110),
                                        ],
                                      ))
                                    : Column(children: [
                                        userField,
                                        SizedBox(height: 20.0),
                                        passwordField,
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        passwordValidationField,
                                        SizedBox(height: 20),
                                        cityNameField,
                                      ]);
                              }),
                              SizedBox(height: 15),
                              ToggleableElevatedButton(
                                  text: Strings.registration.tr,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.register(
                                          username: usernameController.text,
                                          password: passwordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text,
                                          countryName: citynameController.text,
                                          onSuccess: () {
                                            Get.back();
                                            UnderseaStyles.snackbar(
                                              Strings.registr_snackbar_title.tr,
                                              Strings.registr_snackbar_body.tr,
                                            );
                                          });
                                    }
                                  },
                                  isDisabled: hasError),
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
                )))));
  }
}
