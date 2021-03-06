import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/response/country_details_dto.dart';
import 'package:undersea/network/providers/country_data_provider.dart';
import 'package:undersea/styles/style_constants.dart';

class CountryDataController extends GetxController {
  final CountryDataProvider _countryDataProvider;
  var eventWindowShown = false;

  CountryDataController(this._countryDataProvider);

  Rx<CountryDetailsDto?> countryDetailsData = Rx(null);
  Rx<bool> countryDataLoading = false.obs;
  Rx<String?> countryName = Rx(null);

  void getCountryDetails() async {
    countryDetailsData = null.obs;
    countryDataLoading = true.obs;
    update();
    try {
      final response = await _countryDataProvider.getCountryDetails();
      if (response.statusCode == 200) {
        countryDetailsData = Rx(response.body);
        countryDataLoading = false.obs;
        update();
        log('EVENT: ${countryDetailsData.value?.event}');

        var event = countryDetailsData.value?.event;
        if (event != null && !eventWindowShown) {
          Get.defaultDialog(
              title: "Váratlan esemény",
              backgroundColor: UnderseaStyles.hintColor,
              titleStyle: UnderseaStyles.listBold.copyWith(fontSize: 16),
              barrierDismissible: true,
              radius: 20,
              content: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                      width: 300,
                      height: 320,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Image.asset(
                              UnderseaStyles.randomEventImageMap[event.name]!,
                              width: 130,
                              height: 130,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(event.name!, style: UnderseaStyles.listBold),
                          SizedBox(height: 5),
                          for (var effect in event.effects!)
                            Text(effect.name!,
                                style: UnderseaStyles.listRegular),
                          Expanded(child: Container()),
                          UnderseaStyles.elevatedButton(
                              text: 'Ok',
                              width: 100,
                              height: 40,
                              onPressed: () {
                                eventWindowShown = true;
                                Get.back();
                              }),
                        ],
                      ))));
        }
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
      countryName.value = null;
      update();
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
