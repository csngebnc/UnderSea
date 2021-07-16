import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/core/constants.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/models/response/login_response.dart';
import 'package:undersea/modules/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:undersea/network/providers/user_data_provider.dart';

class LoginController extends GetxController
    with StateMixin<Rx<LoginResponse>> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginController(this._userDataProvider);

  final UserDataProvider _userDataProvider;
  var storage = GetStorage();

  var hasError = false;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  login() async {
    change(Rx(LoginResponse()), status: RxStatus.loading());
    try {
      final body =
          'username=${usernameController.text}&password=${passwordController.text}&grant_type=password&client_id=undersea-flutter&scope=openid+api-openid';
      final response = await _userDataProvider.login(body);
      if (response.statusCode == 200) {
        change(Rx(response.body!), status: RxStatus.success());
        storage.write(Constants.TOKEN, state!.call().token);
        Get.offNamed(BottomNavigationBarScreen.routeName);
      } else {
        change(Rx(LoginResponse()),
            status: RxStatus.error(Strings.invalid_username_password.tr));
        Constants.snackbar(
            Strings.error_occurred.tr, Strings.invalid_username_password.tr);
      }
    } catch (error) {
      log('$error');
      change(Rx(LoginResponse()), status: RxStatus.empty());
      Constants.snackbar(Strings.error.tr, Strings.something_went_wrong.tr);
    }
  }
}
