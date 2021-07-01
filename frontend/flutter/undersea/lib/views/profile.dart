import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/player_controller.dart';
import 'package:undersea/controllers/user_data_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/response/user_info_dto.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/editable_text.dart';
import 'package:undersea/views/login.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserInfoDto?> userInfo;

  final userDataController = Get.find<UserDataController>();

  @override
  void initState() {
    //userInfo = userDataController.userInfo();
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
              GetBuilder<UserDataController>(builder: (controller) {
                final userInfoData = controller.userInfoData.value;
                if (userInfoData != null)
                  return Text(userInfoData.name!,
                      style: UnderseaStyles.inputTextStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21));
                /*else if (snapshot.hasError)
                      return Text('error',
                          style: UnderseaStyles.inputTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21));*/
                else
                  return Text('default',
                      style: UnderseaStyles.inputTextStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21));
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
                      child: CityNameEditableText('Óceánia')),
                  UnderseaStyles.divider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextButton(
                        onPressed: () {
                          Get.off(LoginPage());
                          //logout
                        },
                        child: Text(Strings.logout.tr,
                            style: UnderseaStyles.buttonTextStyle.copyWith(
                                color: UnderseaStyles.underseaLogoColor)),
                      ),
                    ),
                  ),
                  UnderseaStyles.divider()
                ]))
          ]),
        ));
  }
}
