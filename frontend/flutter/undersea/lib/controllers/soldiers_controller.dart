import 'package:get/get.dart';
import 'package:undersea/models/soldier.dart';

class SoldiersController extends GetxController {
  var soldierList = <Soldier>[
    Soldier(
        totalAmount: 20,
        attack: 5,
        defence: 5,
        payment: 1,
        supplyNeeds: 1,
        name: 'Lézercápa',
        price: 200,
        available: 10,
        iconName: 'shark'),
    Soldier(
        totalAmount: 30,
        attack: 2,
        defence: 6,
        payment: 1,
        supplyNeeds: 1,
        name: 'Rohamfóka',
        price: 50,
        available: 22,
        iconName: 'seal'),
    Soldier(
        totalAmount: 52,
        attack: 6,
        defence: 2,
        payment: 1,
        supplyNeeds: 1,
        name: 'Csatacsikó',
        price: 50,
        available: 41,
        iconName: 'seahorse')
  ].obs;
}
