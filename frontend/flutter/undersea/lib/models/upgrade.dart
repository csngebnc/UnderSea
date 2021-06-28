import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Upgrade {
  String name;
  String imageName;
  String effect;
  int? availableIn;
  bool isInProgress;
  bool isAvailable;

  Upgrade(
      {required this.name,
      required this.imageName,
      required this.effect,
      this.availableIn,
      required this.isInProgress,
      required this.isAvailable});
}
