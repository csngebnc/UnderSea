import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/lang/app_translations.dart';
import 'package:undersea/views/login.dart';
import 'lang/strings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static String _title = Strings.undersea.tr;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: AppTranslations.locale,
      fallbackLocale: AppTranslations.fallbackLocale,
      translations: AppTranslations(),
      title: _title,
      home: LoginPage(),
    );
  }
}
