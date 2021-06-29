import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/views/registration.dart';
import 'bottom_nav_bar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle buttonTextStyle = TextStyle(
      fontFamily: 'Baloo 2',
      fontSize: 20.0,
      color: Color(0xFF001234),
      fontWeight: FontWeight.bold);
  TextStyle inputTextStyle = TextStyle(fontFamily: 'Open Sans', fontSize: 15);

  @override
  Widget build(BuildContext context) {
    final userField = Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0), color: Colors.white),
        child: TextField(
          style: inputTextStyle,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Felhasználónév",
              hintStyle: TextStyle(color: Color(0xFF1C3E76), fontSize: 19),
              border: InputBorder.none),
        ));
    final passwordField = Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0), color: Colors.white),
        child: TextField(
          obscureText: true,
          style: inputTextStyle,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Jelszó",
              hintStyle: TextStyle(color: Color(0xFF1C3E76), fontSize: 19),
              border: InputBorder.none),
        ));

    final loginButton = ElevatedButton(
      onPressed: () {
        //szerverre, ha autentikáció sikeres, zsa
        Get.to(BottomNavBar());
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 10,
          shadowColor: Color(0xFF3B7DBD),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(200))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [Color(0xff9FFFF0), Color(0xff6BEEE9), Color(0xff0FCFDE)],
            ),
            borderRadius: BorderRadius.circular(200)),
        child: Container(
          width: 250,
          height: 70,
          alignment: Alignment.center,
          child: Text(
            'Belépés',
            style: buttonTextStyle.copyWith(fontSize: 24),
          ),
        ),
      ),
    );

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/background/sign in bg@3x.png',
                    //height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                  ),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(children: [
                SizedBox(height: 30),
                SizedBox(
                  child: Text('UNDERSEA',
                      style: buttonTextStyle.copyWith(
                          fontSize: 46, color: Color(0xFF9FFFF0))),
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
                                style: buttonTextStyle.copyWith(fontSize: 24),
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
                              child:
                                  Text('Regisztráció', style: buttonTextStyle)),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            )));
  }
}
