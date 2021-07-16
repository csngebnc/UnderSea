import 'package:get/get.dart';
import 'package:undersea/modules/bottom_nav_bar/bottom_nav_bar_controller.dart';

class BottomNavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationBarController());
  }
}
