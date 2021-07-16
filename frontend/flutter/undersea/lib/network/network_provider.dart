import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/network/urls.dart';

import '../core/constants.dart';

abstract class NetworkProvider extends GetConnect {
  final storage = GetStorage();
  @override
  void onInit() {
    httpClient.baseUrl = Urls.API_URL;

    httpClient.addRequestModifier<dynamic>((request) async {
      request.headers[Constants.AUTH] = token;
      return request;
    });
  }

  String get token => 'Bearer ${storage.read(Constants.TOKEN)}';
}
