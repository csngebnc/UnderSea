import 'package:get/get.dart';
import 'package:undersea/constants.dart';
import 'package:undersea/network/response/login_response.dart';

import 'network_provider.dart';

class LoginProvider extends NetworkProvider {
  Future<Response<LoginResponse>> login(
          /*Map<String, String> queryParams,*/ String body) =>
      post("/connect/token" /* + body,*/, body,
          //query: queryParams,
          contentType: 'application/x-www-form-urlencoded',
          decoder: (response) => LoginResponse(response['access_token']));

  /* storage.write(Constants.TOKEN, response['token'])}); Get.snackbar(Strings.registr_snackbar_title.tr,
              Strings.registr_snackbar_body.tr,
              icon: Icon(Icons.app_registration),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blueAccent);}));
*/
  /* Future<Response<MovieDetails>> getMovieDetails(int id) => get("/movie/$id",
      query: {"api_key": "b74d1e6003335ca2ba7154a6c0a4e35b"},
      decoder: (response) => MovieDetails.fromJson(response));*/
}

/*sstrahan0
Aa1234.*/