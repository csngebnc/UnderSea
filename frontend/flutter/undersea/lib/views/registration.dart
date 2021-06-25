import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/styles/style_constants.dart';
import 'bottom_nav_bar.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    final userField = UnderseaStyles.inputField(hint: "Felhasználónév");
    final passwordField =
        UnderseaStyles.inputField(hint: "Jelszó", isPassword: true);
    final passwordValidationField = UnderseaStyles.inputField(
        hint: "Jelszó megerősítése", isPassword: true);
    final cityNameField =
        UnderseaStyles.inputField(hint: "A városod neve, amit építesz");

    final registrationButton = UnderseaStyles.elevatedButton(
        text: "Regisztráció",
        onPressed: () {
          //regisztráció felküldése a szerverre

          //siker esetén:

          Get.back();
          Get.snackbar('Sikeres regisztráció!', 'Lépj be a játékhoz!',
              icon: Icon(Icons.app_registration),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blueAccent);
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
                                'Belépés',
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
                              child: Text('Belépés',
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
