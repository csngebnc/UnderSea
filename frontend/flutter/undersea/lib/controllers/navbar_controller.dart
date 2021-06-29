import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  var selectedTab = 0.obs;
  setValue(int value) => selectedTab.value;
}
