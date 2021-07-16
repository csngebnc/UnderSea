import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/models/response/building_details_dto.dart';
import 'package:undersea/models/response/buy_building_dto.dart';
import 'package:undersea/network/providers/building_data_provider.dart';
import 'package:undersea/styles/style_constants.dart';

class BuildingService extends GetxController {
  final BuildingDataProvider _buildingDataProvider;

  Rx<List<BuildingDetailsDto>> buildingInfoData = Rx([]);

  BuildingService(this._buildingDataProvider);

  buyBuilding(int id) async {
    try {
      final response = await _buildingDataProvider
          .buyBuilding(BuyBuildingDto(buildingId: id).toJson());

      if (response.statusCode == 200) {
        UnderseaStyles.snackbar(
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

  static const imageNameMap = {
    'Szonárágyú': 'szonaragyu',
    'Zátonyvár': 'zatonyvar',
    'Áramlásirányító': 'aramlasiranyito',
    'Kőbánya': 'stone_mine'
  };

  void reset() {
    buildingInfoData = Rx([]);
  }
}
