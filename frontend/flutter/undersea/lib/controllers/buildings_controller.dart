import 'package:get/get.dart';
import 'package:undersea/models/building.dart';

class BuildingsController extends GetxController {
  var buildingList = <Building>[
    Building(
        name: 'Zátonyvár',
        effect1: '50 ember-t ad a népességhez',
        effect2: '200 krumplit termel körönként',
        currentAmount: 4,
        price: 35,
        availableIn: 0,
        imageName: "zatonyvar",
        isInProgress: false,
        isAvailable: true),
    Building(
        name: 'Áramlásirányító',
        effect1: '200 egységnek nyújt szállást',
        currentAmount: 3,
        price: 280, //35
        availableIn: 4,
        imageName: "aramlasiranyito",
        isInProgress: false, ////
        isAvailable: false),
  ].obs;
}
