import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/models/response/battle_unit_dto.dart';
import 'package:undersea/models/response/buy_unit_dto.dart';

import 'package:undersea/models/response/paged_result_of_attackable_user_dto.dart';
import 'package:undersea/models/response/paged_result_of_logged_attack_dto.dart';
import 'package:undersea/models/response/paged_result_of_spy_report_dto.dart';
import 'package:undersea/models/response/send_attack_dto.dart';
import 'package:undersea/models/response/send_spy_dto.dart';
import 'package:undersea/models/response/unit_dto.dart';
import 'package:undersea/models/soldier.dart';

import 'package:undersea/network/providers/battle_data_provider.dart';

import 'package:undersea/styles/style_constants.dart';

class BattleDataController extends GetxController {
  final BattleDataProvider _battleDataProvider;
  BattleDataController(this._battleDataProvider);
  var searchText = ''.obs;
  var pageNumber = 1.obs;
  var pageSize = 20.obs;
  var actualPageSize = 20.obs;
  Rx<List<BattleUnitDto>> availableUnitsInfo = Rx([]);
  Rx<List<BattleUnitDto>> allUnitsInfo = Rx([]);
  Rx<BattleUnitDto?> spiesInfo = Rx(null);
  Rx<PagedResultOfLoggedAttackDto?> loggedAttacks = Rx(null);
  Rx<PagedResultOfAttackableUserDto?> attackableUsers = Rx(null);
  Rx<PagedResultOfSpyReportDto?> spyingHistory = Rx(null);
  Rx<List<UnitDto>> unitTypesInfo = Rx([]);

  static const imageNameMap = {
    'Lézercápa': 'shark',
    'Rohamfóka': 'seal',
    'Csatacsikó': 'seahorse',
    'Felfedező': 'dora'
  };

  @override
  void onInit() {
    debounce(searchText, (String value) {
      getAttackableUsers();
    }, time: Duration(milliseconds: 500));
    super.onInit();
  }

  void onSearchChanged(String value) {
    searchText.value = value;
  }

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
        iconName: 'seahorse'),
    Soldier(
        totalAmount: 20,
        attack: 0,
        defence: 0,
        payment: 50,
        supplyNeeds: 5,
        name: 'Felfedező',
        price: 50,
        iconName: 'dora',
        available: 2),
  ].obs;

  getAvailableUnits() async {
    try {
      final response = await _battleDataProvider.getAvailableUnits();
      if (response.statusCode == 200) {
        availableUnitsInfo = Rx(response.body!);
        update();
      }
    } catch (error) {
      log('$error');
    }
  }

  getAllUnits() async {
    try {
      final response = await _battleDataProvider.getAllUnits();
      if (response.statusCode == 200) {
        allUnitsInfo = Rx(response.body!);
        update();
      }
    } catch (error) {
      log('$error');
    }
  }

  getSpies() async {
    try {
      final response = await _battleDataProvider.getSpies();
      if (response.statusCode == 200) {
        spiesInfo = Rx(response.body!);
        update();
      }
    } catch (error) {
      log('$error');
    }
  }

  attack(SendAttackDto attackData) async {
    try {
      final response = await _battleDataProvider.attack(attackData.toJson());
      if (response.statusCode == 200) {
        UnderseaStyles.snackbar(
            'Sikeres támadás!', 'Az egységeidet elküldted támadni');
      }
    } catch (error) {
      log('$error');
    }
  }

  sendSpies(SendSpyDto spyData) async {
    try {
      final response = await _battleDataProvider.sendSpies(spyData.toJson());
      if (response.statusCode == 200) {
        UnderseaStyles.snackbar('Sikeresen elküldted a felfedezőid!',
            'Az egységeidet elküldted felfedezésre');
      }
    } catch (error) {
      log('$error');
    }
  }

  getHistory(int pageSize, int pageNumber) async {
    try {
      final response =
          await _battleDataProvider.getHistory(pageSize, pageNumber);
      if (response.statusCode == 200) {
        loggedAttacks = Rx(response.body!);
        update();
      }
    } catch (error) {
      log('$error');
    }
  }

  getAttackableUsers() async {
    try {
      final response = await _battleDataProvider.getAttackableUsers(
          pageSize.value, pageNumber.value, searchText.value);
      if (response.statusCode == 200) {
        attackableUsers = Rx(response.body!);
        actualPageSize.value = attackableUsers.value!.allResultsCount;
        update();
      }
    } catch (error) {
      log('$error');
    }
  }

  getSpyingHistory(int pageSize, int pageNumber, String name) async {
    try {
      final response = await _battleDataProvider.getSpyingHistory(
          pageSize, pageNumber, name);
      if (response.statusCode == 200) {
        spyingHistory = Rx(response.body!);
        update();
      }
    } catch (error) {
      log('$error');
    }
  }

  getUnitTypes() async {
    try {
      final response = await _battleDataProvider.getUnitTypes();
      if (response.statusCode == 200) {
        unitTypesInfo = Rx(response.body!);
        update();
      }
    } catch (error) {
      log('$error');
    }
  }

  buyUnits(BuyUnitDto purchase) async {
    try {
      final response = await _battleDataProvider.buyUnits(purchase.toJson());
      if (response.statusCode == 200) {
        getAllUnits();
        getUnitTypes();
        getSpies();
        UnderseaStyles.snackbar(
            'Sikeres vásárlás', 'Új egységeid besorolásra kerültek');
      }
    } catch (error) {
      log('$error');
    }
  }
}
