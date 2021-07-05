import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/models/response/register_dto.dart';
import 'package:undersea/models/response/user_info_dto.dart';

import 'package:undersea/network/providers/user_data_provider.dart';
import 'package:undersea/styles/style_constants.dart';
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
          userName: username,
          password: password,
          confirmPassword: confirmPassword,
          countryName: countryName);
      final response =
          await _userDataProvider.register(registrationData.toJson());
      if (response.statusCode == 200) onSuccess != null ? onSuccess() : {};
    } catch (error) {
      UnderseaStyles.snackbar('Error', 'Regisztrációs hiba');
    }
  }

  login(String username, String password) async {
    try {
      final body =
          'username=$username&password=$password&grant_type=password&client_id=undersea-angular&scope=openid+api-openid';
      final response = await _userDataProvider.login(body);
      if (response.body != null) {
        storage.write(Constants.TOKEN, response.body!.token);
        Get.off(BottomNavBar());
      }
    } catch (error) {
      UnderseaStyles.snackbar('Error', 'Bejelentkezési hiba');
    }
  }

  void userInfo() async {
    try {
      final response = await _userDataProvider.getUserInfo();
      if (response.statusCode == 200) {
        userInfoData = Rx(response.body);
        update();
      }
    } catch (error) {
      userInfoData.addError(error);
      log('$error');
    }
  }
}
