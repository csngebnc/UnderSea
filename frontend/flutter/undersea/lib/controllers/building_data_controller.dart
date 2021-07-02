import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/models/response/building_details_dto.dart';
import 'package:undersea/models/response/building_details_list.dart';
import 'package:undersea/models/response/building_info_dto.dart';
import 'package:undersea/models/response/buy_building_dto.dart';
import 'package:undersea/models/response/register_dto.dart';
import 'package:undersea/models/response/user_info_dto.dart';
import 'package:undersea/network/providers/building_data_provider.dart';

import 'package:undersea/network/providers/user_data_provider.dart';
import 'package:undersea/views/bottom_nav_bar.dart';

import '../constants.dart';

class BuildingDataController extends GetxController {
  final BuildingDataProvider _buildingDataProvider;

  Rx<List<BuildingDetailsDto>> buildingInfoData = Rx([]);

  BuildingDataController(this._buildingDataProvider);

  buyBuilding(int id) async {
    try {
      final response = await _buildingDataProvider
          .buyBuilding(BuyBuildingDto(buildingId: id).toJson());

      if (response.statusCode == 200) {
        Get.snackbar('Sikeres vásárlás!', '');
        getBuildingDetails();
      }
    } catch (error) {
      log('$error');
    }
  }

  getBuildingDetails() async {
    try {
      final response = await _buildingDataProvider.getBuildingDetails();
      if (response.statusCode == 200) {
        buildingInfoData = Rx(response.body!);
        update();
      }
    } catch (error) {
      log('$error');
    }
  }

  static const imageNameMap = {
    'Zátonyvár': 'zatonyvar',
    'Áramlásirányító': 'aramlasiranyito'
  };
}
