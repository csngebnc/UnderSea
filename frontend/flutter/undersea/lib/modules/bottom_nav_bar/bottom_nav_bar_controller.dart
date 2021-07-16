import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  var selectedTab = 0.obs;

  void setIndex(int value) => selectedTab.value = value;
  get tabIndex => selectedTab.value;

  void toHomePage() => setIndex(0);
}
