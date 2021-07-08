import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/models/response/paged_result_of_user_rank_dto.dart';
import 'package:undersea/models/response/register_dto.dart';
import 'package:undersea/models/response/user_info_dto.dart';
import 'package:undersea/models/response/user_rank_dto.dart';

import 'package:undersea/network/providers/user_data_provider.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/bottom_nav_bar.dart';

import '../constants.dart';

class UserDataController extends GetxController {
  final UserDataProvider _userDataProvider;
  var storage = GetStorage();

  Rx<UserInfoDto?> userInfoData = Rx(null);

  UserDataController(this._userDataProvider);

  Rx<PagedResultOfUserRankDto?> pagedRankList = Rx(null);
  var searchText = ''.obs;
  var pageNumber = 1.obs;
  var alreadyDownloadedPageNumber = 0.obs;
  var pageSize = 10.obs;
  var rankList = <UserRankDto>[].obs;

  @override
  void onInit() {
    debounce(searchText, (String value) {
      getRankList();
    }, time: Duration(milliseconds: 500));
    super.onInit();
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    pageNumber.value = 1;
    alreadyDownloadedPageNumber.value = 0;
    rankList.value.clear();
  }

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

  getRankList() async {
    try {
      if (pagedRankList.value != null &&
          pagedRankList.value!.allResultsCount <=
              alreadyDownloadedPageNumber.value * pageSize.value) return;
      final response = await _userDataProvider.getRankList(pageSize.value,
          pageNumber.value, searchText.value.removeAllWhitespace);
      if (response.statusCode == 200) {
        pagedRankList = Rx(response.body!);
        if (alreadyDownloadedPageNumber.value !=
            pagedRankList.value!.pageNumber) {
          rankList.value += pagedRankList.value?.results ?? [];
          alreadyDownloadedPageNumber.value = pageNumber.value;
        }
        update();
      }
    } catch (error) {
      log('$error');
    }
  }

  void reset() {
    pagedRankList = Rx(null);
    searchText.value = '';
    pageNumber.value = 1;
    alreadyDownloadedPageNumber.value = 0;
    pageSize.value = 5;
    rankList.value.clear();
  }
}
