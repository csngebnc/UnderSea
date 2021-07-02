import 'package:get/get.dart';
import 'package:undersea/models/response/building_details_dto.dart';
import 'package:undersea/models/response/country_details_dto.dart';

import '../../constants.dart';
import 'network_provider.dart';

class BuildingDataProvider extends NetworkProvider {
  Future<Response<BuildingDetailsDto>> getBuildingDetails() =>
      get("/api/Building/user-buildings",
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          decoder: (response) {
        return BuildingDetailsDto.fromJson(response);
      });

  Future<Response<void>> buyBuilding(Map<String, dynamic> body) =>
      post("/api/Building/buy", body,
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          contentType: 'application/json',
          decoder: (response) => {});
}
