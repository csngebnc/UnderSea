import 'package:get/get.dart';
import 'package:undersea/models/response/paged_result_of_user_rank_dto.dart';
import 'package:undersea/models/response/user_info_dto.dart';
import 'package:undersea/models/response/login_response.dart';
import 'network_provider.dart';

class UserDataProvider extends NetworkProvider {
  Future<Response<LoginResponse>> login(String body) =>
      post("/connect/token", body,
          contentType: 'application/x-www-form-urlencoded',
          decoder: (response) => LoginResponse(response['access_token']));

  Future<Response<void>> register(Map<String, dynamic> body) =>
      post("/api/User/register", body,
          contentType: 'application/json', decoder: (response) => {});

  Future<Response<UserInfoDto>> getUserInfo() =>
      get("/api/User", contentType: 'application/json', decoder: (response) {
        return UserInfoDto.fromJson(response);
      });

  Future<Response<PagedResultOfUserRankDto>> getRankList(
          int pageSize, int pageNumber, String name) =>
      get("/api/User/ranklist", contentType: 'application/json', query: {
        'PageSize': '$pageSize',
        'PageNumber': '$pageNumber',
        'name': name
      }, decoder: (response) {
        return PagedResultOfUserRankDto.fromJson(response);
      });
}
