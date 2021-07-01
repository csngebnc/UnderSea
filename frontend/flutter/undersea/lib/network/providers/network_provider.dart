import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants.dart';

abstract class NetworkProvider extends GetConnect {
  final storage = GetStorage();
  @override
  void onInit() {
    httpClient.baseUrl = "https://api-undersea.azurewebsites.net/";

    httpClient.addRequestModifier((request) =>
        request.headers['Authorization'] = storage.read(Constants.TOKEN));

    /*httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] = storage.read(Constants.TOKEN);
      return request;
    });*/
  }
}
