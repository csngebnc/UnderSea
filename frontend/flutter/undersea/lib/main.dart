import 'package:flutter/material.dart';
import 'views/bottom_nav_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Undersea';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: BottomNavBar(),
    );
  }
}
