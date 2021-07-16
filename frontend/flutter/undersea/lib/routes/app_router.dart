import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:undersea/modules/bottom_nav_bar/bottom_nav_bar_binding.dart';
import 'package:undersea/modules/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:undersea/modules/login/login_binding.dart';
import 'package:undersea/modules/login/login_screen.dart';

class AppRouter {
  static const INITIAL = LoginScreen.routeName;

  static final routes = [
    GetPage(
      name: BottomNavigationBarScreen.routeName,
      page: () => BottomNavigationBarScreen(),
      binding: BottomNavigationBarBinding(),
    ),
    GetPage(
      name: LoginScreen.routeName,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}
