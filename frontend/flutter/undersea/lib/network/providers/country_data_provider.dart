import 'package:get/get.dart';
import 'package:undersea/models/response/country_details_dto.dart';

import '../../constants.dart';
import 'network_provider.dart';

class CountryDataProvider extends NetworkProvider {
  Future<Response<CountryDetailsDto>> getCountryDetails() => get("/api/Country",
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
          decoder: (response) {
        return CountryDetailsDto.fromJson(response);
      });

  Future<Response<String>> getCountryName() => get("/api/Country/name",
      headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
      contentType: 'application/json',
      decoder: (response) => response.toString());

  Future<Response<void>> setCountryName(String countryName) => put(
        "/api/Country/name",
        {},
        query: {'name': countryName},
        contentType: 'application/json',
        headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
      );
}
