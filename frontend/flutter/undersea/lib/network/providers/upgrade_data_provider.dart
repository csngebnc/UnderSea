import 'package:get/get.dart';
import 'package:undersea/models/response/upgrade_dto.dart';

import '../../constants.dart';
import 'network_provider.dart';

class UpgradeDataProvider extends NetworkProvider {
  Future<Response<List<UpgradeDto>>> getUpgradeDetails() =>
      get("/api/Upgrade/list",
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          decoder: (response) {
        return (response as List).map((e) => UpgradeDto.fromJson(e)).toList();
      });

  Future<Response<void>> buyUpgrade(Map<String, dynamic> body) =>
      post("/api/Upgrade/buy", body,
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          contentType: 'application/json',
          decoder: (response) => {});
}
