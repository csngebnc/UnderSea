import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/core/constants.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/models/response/building_details_dto.dart';
import 'package:undersea/models/response/buy_building_dto.dart';
import 'package:undersea/network/providers/building_data_provider.dart';

class BuildingService extends GetxController {
  final BuildingDataProvider _buildingDataProvider;

  Rx<List<BuildingDetailsDto>> buildingInfoData = Rx([]);

  BuildingService(this._buildingDataProvider);

  buyBuilding(int id) async {
    try {
      final response = await _buildingDataProvider
          .buyBuilding(BuyBuildingDto(buildingId: id).toJson());

      if (response.statusCode == 200) {
        Constants.snackbar(
            Strings.successful_purchase.tr, Strings.new_building.tr);
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

  void reset() {
    buildingInfoData = Rx([]);
  }
}
