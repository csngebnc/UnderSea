import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/views/login.dart';
import 'views/bottom_nav_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Undersea';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: _title,
      home: LoginPage(title: 'loginpage'), //BottomNavBar(),
    );
  }
}
