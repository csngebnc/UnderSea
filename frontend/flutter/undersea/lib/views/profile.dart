import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/models/response/user_info_dto.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/services/building_service.dart';
import 'package:undersea/services/event_service.dart';
import 'package:undersea/services/upgrade_service.dart';
import 'package:undersea/services/user_service.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/editable_text.dart';
import 'package:undersea/views/login.dart';

import '../core/constants.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserInfoDto?> userInfo;

  final userService = Get.find<UserService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UnderseaStyles.menuDarkBlue,
        appBar: AppBar(
          title: Text(Strings.profile.tr),
          backgroundColor: UnderseaStyles.hintColor,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Center(
                child: Column(children: [
              SizedBox(
                height: 40,
              ),
              UnderseaStyles.assetIcon("profile", iconSize: 70),
              SizedBox(
                height: 25,
              ),
              GetBuilder<UserService>(builder: (controller) {
                final userInfoData = controller.userInfoData.value;
                if (userInfoData != null) {
                  return Text(userInfoData.name!,
                      style: UnderseaStyles.inputTextStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17));
                }
                /*else if (snapshot.hasError)
                      return Text('error',
                          style: UnderseaStyles.inputTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21));*/
                else {
                  return CircularProgressIndicator();
                  /*Text('default',
                      style: UnderseaStyles.inputTextStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21));*/
                }
              }),
              SizedBox(
                height: 10,
              ),
              UnderseaStyles.divider(),
              SizedBox(
                height: 10,
              ),
            ])),
            Align(
                alignment: Alignment.centerLeft,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CityNameEditableText(),
                  ),
                  UnderseaStyles.divider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextButton(
                        onPressed: () {
                          var storage = GetStorage();
                          storage.remove(Constants.TOKEN);
                          Get.find<BuildingService>().reset();
                          Get.find<UpgradeService>().reset();
                          Get.find<BattleService>().reset();
                          Get.find<EventService>().reset();
                          storage.remove(Constants.WINNER_SHOWN);
                          Get.off(LoginPage());
                        },
                        child: Text(Strings.logout.tr,
                            style: UnderseaStyles.buttonTextStyle.copyWith(
                                color: UnderseaStyles.underseaLogoColor,
                                fontSize: 17)),
                      ),
                    ),
                  ),
                  UnderseaStyles.divider()
                ]))
          ]),
        ));
  }
}
