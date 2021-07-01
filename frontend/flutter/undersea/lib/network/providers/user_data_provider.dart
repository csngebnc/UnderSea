import 'package:get/get.dart';
import 'package:undersea/models/response/user_info_dto.dart';
import 'package:undersea/network/response/login_response.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

import '../../constants.dart';
import 'network_provider.dart';

class UserDataProvider extends NetworkProvider {
  Future<Response<LoginResponse>> login(String body) =>
      post("/connect/token", body,
          contentType: 'application/x-www-form-urlencoded',
          decoder: (response) => LoginResponse(response['access_token']));

  Future<Response<void>> register(Map<String, dynamic> body) =>
      post("/api/User/register", body,
          contentType: 'application/json', decoder: (response) => {});

  Future<Response<UserInfoDto>> getUserInfo() => get("/api/User",
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          decoder: (response) {
        return UserInfoDto.fromJson(response);
      });
}
