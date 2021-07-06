import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/models/response/battle_unit_dto.dart';
import 'package:undersea/models/response/building_details_dto.dart';
import 'package:undersea/models/response/building_details_list.dart';
import 'package:undersea/models/response/country_details_dto.dart';
import 'package:undersea/models/response/paged_result_of_attackable_user_dto.dart';
import 'package:undersea/models/response/paged_result_of_logged_attack_dto.dart';
import 'package:undersea/models/response/paged_result_of_spy_report_dto.dart';
import 'package:undersea/models/response/unit_dto.dart';

import '../../constants.dart';
import 'network_provider.dart';

class BattleDataProvider extends NetworkProvider {
  Future<Response<List<BattleUnitDto>>> getAvailableUnits() =>
      get("/api/Battle/available-units",
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          decoder: (response) {
        log(response.toString());
        return (response as List)
            .map((e) => BattleUnitDto.fromJson(e))
            .toList();
      });

  Future<Response<List<BattleUnitDto>>> getAllUnits() =>
      get("/api/Battle/all-units",
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          decoder: (response) {
        log(response.toString());
        return (response as List)
            .map((e) => BattleUnitDto.fromJson(e))
            .toList();
      });

  Future<Response<BattleUnitDto>> getSpies() => get("/api/Battle/spies",
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          decoder: (response) {
        log(response.toString());
        return BattleUnitDto.fromJson(response);
      });

  Future<Response<void>> attack(Map<String, dynamic> body) =>
      post("/api/Battle/attack", body,
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          contentType: 'application/json',
          decoder: (response) => {});

  Future<Response<void>> sendSpies(Map<String, dynamic> body) =>
      post("/api/Battle/spy", body,
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          contentType: 'application/json',
          decoder: (response) => {});

  Future<Response<PagedResultOfLoggedAttackDto>> getHistory(
          int pageSize, int pageNumber) =>
      get("/api/Battle/history",
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          contentType: 'application/json',
          query: {'PageNumber': '$pageNumber', 'PageSize': '$pageSize'},
          decoder: (response) =>
              PagedResultOfLoggedAttackDto.fromJson(response));

  Future<Response<PagedResultOfAttackableUserDto>> getAttackableUsers(
          int pageSize, int pageNumber, String name) =>
      get("/api/Battle/attackable-users",
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          contentType: 'application/json',
          query: {
            'PageNumber': pageNumber.toString(),
            'PageSize': pageSize.toString(),
            'name': name
          },
          decoder: (response) =>
              PagedResultOfAttackableUserDto.fromJson(response));

  Future<Response<PagedResultOfSpyReportDto>> getSpyingHistory(
          int pageSize, int pageNumber, String name) =>
      get("/api/Battle/spy-history",
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          contentType: 'application/json',
          query: {'PageNumber': pageNumber, 'PageSize': pageSize, 'name': name},
          decoder: (response) => PagedResultOfSpyReportDto.fromJson(response));

  Future<Response<List<UnitDto>>> getUnitTypes() => get("/api/Battle/units",
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          decoder: (response) {
        return (response as List).map((e) => UnitDto.fromJson(e)).toList();
      });

  Future<Response<void>> buyUnits(Map<String, dynamic> body) =>
      post("/api/Battle/buy-unit", body,
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          decoder: (response) {});
}
