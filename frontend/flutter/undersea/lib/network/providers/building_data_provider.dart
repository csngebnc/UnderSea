import 'package:get/get.dart';
import 'package:undersea/models/response/building_details_dto.dart';

import '../network_provider.dart';

class BuildingDataProvider extends NetworkProvider {
  Future<Response<List<BuildingDetailsDto>>> getBuildingDetails() =>
      get("/api/Building/user-buildings", contentType: 'application/json',
          decoder: (response) {
        //log(response.toString());
        return (response as List)
            .map((e) => BuildingDetailsDto.fromJson(e))
            .toList();
      });

  Future<Response<void>> buyBuilding(Map<String, dynamic> body) =>
      post("/api/Building/buy", body,
          contentType: 'application/json', decoder: (response) => {});
}
