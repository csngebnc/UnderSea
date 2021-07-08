import 'dart:developer';
import 'package:get/get.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/response/country_details_dto.dart';
import 'package:undersea/network/providers/country_data_provider.dart';
import 'package:undersea/styles/style_constants.dart';

class CountryDataController extends GetxController {
  final CountryDataProvider _countryDataProvider;

  CountryDataController(this._countryDataProvider);

  Rx<CountryDetailsDto?> countryDetailsData = Rx(null);
  Rx<String?> countryName = Rx(null);

  void getCountryDetails() async {
    try {
      final response = await _countryDataProvider.getCountryDetails();
      if (response.statusCode == 200) {
        countryDetailsData = Rx(response.body);
        update();
        /*userInfoData.update((val) {
          val = response.body;
        });*/
        //return response.body;
      }
    } catch (error) {
      //countryDetailsData.addError(error);
      log('$error');
    }
  }

  void setCountryName(String newName) async {
    try {
      final response = await _countryDataProvider.setCountryName(newName);
      if (response.statusCode == 200) {
        countryName = Rx(newName);
        update();
        UnderseaStyles.snackbar(
          Strings.city_modified_snack_title.tr,
          Strings.city_modified_snack_body.tr + ': $newName',
        );
        /*userInfoData.update((val) {
          val = response.body;
        });*/
        //return response.body;
      }
    } catch (error) {
      //countryDetailsData.addError(error);
      log('$error');
    }
  }

  void getCountryName() async {
    try {
      final response = await _countryDataProvider.getCountryName();
      if (response.statusCode == 200) {
        countryName = Rx(response.body);
        update();
        /*userInfoData.update((val) {
          val = response.body;
        });*/
        //return response.body;
      }
    } catch (error) {
      //countryDetailsData.addError(error);
      log('$error');
    }
  }
}
