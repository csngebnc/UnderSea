import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/views/registration.dart';
import 'bottom_nav_bar.dart';
import 'package:undersea/styles/style_constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final userField = UnderseaStyles.inputField(hint: 'Felhasználónév');
    final passwordField =
        UnderseaStyles.inputField(hint: "Jelszó", isPassword: true);

    final loginButton = UnderseaStyles.elevatedButton(
        text: 'Belépés',
        onPressed: () {
          Get.off(BottomNavBar());
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
              child: Column(children: [
                SizedBox(height: 30),
                SizedBox(
                  child: Text('UNDERSEA',
                      style: UnderseaStyles.buttonTextStyle.copyWith(
                          fontSize: 46,
                          color: UnderseaStyles.underseaLogoColor)),
                ),
                //SizedBox(height: 25),
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
                                'Belépés',
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
                              child: Text('Regisztráció',
                                  style: UnderseaStyles.buttonTextStyle)),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            )));
  }
}
