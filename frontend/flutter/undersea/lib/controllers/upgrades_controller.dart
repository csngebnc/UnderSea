import 'package:get/get.dart';
import 'package:undersea/models/upgrade.dart';

class UpgradesController extends GetxController {
  var upgradeList = <Upgrade>[
    Upgrade(
      availableIn: 3,
      name: "Iszaptraktor",
      imageName: "iszaptraktor",
      effect: "növeli a krumpli termesztést 10%-kal",
      isAvailable: true,
      isInProgress: false,
    ),
    Upgrade(
      availableIn: 3,
      name: "Iszapkombájn",
      imageName: "iszapkombajn",
      effect: "növeli a krumpli termesztést 15%-kal",
      isAvailable: true,
      isInProgress: false,
    ),
    Upgrade(
      availableIn: 5,
      name: "Korallfal",
      imageName: "korallfal",
      effect: "növeli a védelmi pontokat 20%-kal",
      isAvailable: false,
      isInProgress: false,
    ),
    Upgrade(
      availableIn: 3,
      name: "Szonárágyú",
      imageName: "szonaragyu",
      effect: "növeli a támadópontokat 20%-kal",
      isAvailable: false,
      isInProgress: false,
    ),
    Upgrade(
      availableIn: 3,
      name: "Vízalatti harcművészetek",
      imageName: "vizicsillag",
      effect: "növeli a védelmi és támadóerőt 10%-kal",
      isAvailable: false,
      isInProgress: false,
    ),
    Upgrade(
      availableIn: 3,
      name: "Alkímia",
      imageName: "alkimia",
      effect: "növeli a beszedett adót 30%-kal",
      isAvailable: false,
      isInProgress: false,
    ),
  ].obs;
}
