import 'package:get/get.dart';
import 'package:undersea/models/response/upgrade_dto.dart';

import '../network_provider.dart';

class UpgradeDataProvider extends NetworkProvider {
  Future<Response<List<UpgradeDto>>> getUpgradeDetails() =>
      get("/api/Upgrade/list", contentType: 'application/json',
          decoder: (response) {
        return (response as List).map((e) => UpgradeDto.fromJson(e)).toList();
      });

  Future<Response<void>> buyUpgrade(Map<String, dynamic> body) =>
      post("/api/Upgrade/buy", body,
          contentType: 'application/json', decoder: (response) => {});
}
