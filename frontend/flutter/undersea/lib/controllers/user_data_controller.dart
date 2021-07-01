import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/models/response/register_dto.dart';
import 'package:undersea/models/response/user_info_dto.dart';

import 'package:undersea/network/providers/user_data_provider.dart';
import 'package:undersea/views/bottom_nav_bar.dart';

import '../constants.dart';

class UserDataController extends GetxController {
  final UserDataProvider _userDataProvider;
  var storage = GetStorage();

  Rx<UserInfoDto?> userInfoData = Rx(null);

  UserDataController(this._userDataProvider);

  register(
      {required String username,
      required String password,
      required String confirmPassword,
      required String countryName,
      Function? onSuccess}) async {
    try {
      var registrationData = RegisterDto(
          userName: 'Cece1228',
          password: 'trOlOlO.1228',
          confirmPassword: 'trOlOlO.1228',
          countryName: 'Senkifölde');
      final response =
          await _userDataProvider.register(registrationData.toJson());
      if (response.statusCode == 200) onSuccess != null ? onSuccess() : {};
    } catch (error) {
      Get.snackbar('Error', 'Regisztrációs hiba');
      //change(RxList(), status: RxStatus.error("Hiba"));
    }
  }

  login(String username, String password) async {
    //change(LoginResponse(), status: RxStatus.loading());
    try {
      final body =
          'username=$username&password=$password&grant_type=password&client_id=undersea-angular&scope=openid+api-openid';
      final response = await _userDataProvider.login(body);
      if (response.body != null) {
        storage.write(Constants.TOKEN, response.body!.token);
        /*_userDataProvider.httpClient.addAuthenticator<dynamic>((request) async {
          /*request.headers['Authorization'] =
              'Bearer ${storage.read(Constants.TOKEN)}';*/
          return request;
        });*/
        Get.off(BottomNavBar());
      }
    } catch (error) {
      Get.snackbar('Error', 'Bejelentkezési hiba');
      //change(RxList(), status: RxStatus.error("Hiba"));
    }
  }

  void userInfo() async {
    try {
      final response = await _userDataProvider.getUserInfo();
      if (response.statusCode == 200) {
        userInfoData.update((val) {
          val = response.body;
        });
        //return response.body;
      }
    } catch (error) {
      userInfoData.addError(error);
      log('$error');
    }
  }
}
