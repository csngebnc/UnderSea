import 'package:get/get.dart';
import 'package:undersea/network/providers/country_data_provider.dart';

class CountryDataController extends GetxController {
  final CountryDataProvider _countryDataProvider;

  CountryDataController(this._countryDataProvider);

  /*Future<String> getCountryName() async {
    try {
      final response = await _countryDataProvider.getCountryName();
      return response;
    } catch (error) {
      Get.snackbar('Error', '$error');
    }
  }*/
}
