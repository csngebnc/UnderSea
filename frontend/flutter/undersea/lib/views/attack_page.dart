import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/battle_data_controller.dart';

import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/response/attackable_user_dto.dart';

import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/attack_tabs/attack_tab_bar.dart';

class AttackPage extends StatefulWidget {
  @override
  _AttackPageState createState() => _AttackPageState();
}

class _AttackPageState extends State<AttackPage> {
  var controller = Get.find<BattleDataController>();
  final ScrollController _scrollController = ScrollController();

  //late Rx<PagedResultOfAttackableUserDto?> attackableUsersList;

  int? _selectedIndex;
  var sliderValues = List<int>.generate(3, (index) => 0);
  var mercenaryPrice = 0;
  bool firstPage = true;
  late int itemCount;
  List<AttackableUserDto?> results = [];

  @override
  void initState() {
    controller.getAttackableUsers();
    firstPage = true;
    controller.searchText.value = '';
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.pageNumber.value >
            controller.alreadyDownloadedPageNumber.value) return;
        controller.pageNumber.value++;
        controller.getAttackableUsers();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (firstPage)
      return UnderseaStyles.tabSkeleton(
        buttonText: Strings.proceed,
        isDisabled: _selectedIndex == null ? true : false,
        onButtonPressed: () {
          setState(() {
            firstPage = false;
          });
        },
        list: GetBuilder<BattleDataController>(builder: (controller) {
          results = controller.attackableUserList.value;
          itemCount = results.length * 2 + 2;
          return ListView.builder(
              controller: _scrollController,
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int i) {
                if (i == itemCount - 1) return SizedBox(height: 130);
                if (i.isOdd) return UnderseaStyles.divider();
                if (i == 0) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(25, 20, 15, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.first_step.tr,
                              style: UnderseaStyles.listBold
                                  .copyWith(fontSize: 22)),
                          Text(Strings.select.tr,
                              style: UnderseaStyles.listRegular
                                  .copyWith(fontSize: 22)),
                          SizedBox(height: 20),
                          UnderseaStyles.inputField(
                            hint: Strings.username.tr,
                            color: Color(0xFF657A9D),
                            hintColor: UnderseaStyles.alternativeHintColor,
                            onChanged: (value) {
                              setState(() {
                                _selectedIndex = null;
                              });
                              controller.onSearchChanged(value);
                            },
                          )
                        ]),
                  );
                }

                var user = results[i ~/ 2 - 1];

                return ListTile(
                    onTap: () {
                      setState(() {
                        i != _selectedIndex
                            ? _selectedIndex = i
                            : _selectedIndex = null;
                      });
                      controller.countryToBeAttacked = _selectedIndex != null
                          ? controller.attackableUsers.value!
                              .results![_selectedIndex! ~/ 2 - 1].countryId
                          : null;
                    },
                    title: Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 15, 0),
                        child: Row(
                          children: [
                            SizedBox(
                                child: Text('${i ~/ 2}. ',
                                    style: UnderseaStyles.listRegular),
                                width: 30),
                            SizedBox(width: 20),
                            Text(user?.userName ?? '',
                                style: UnderseaStyles.listRegular
                                    .copyWith(fontSize: 20)),
                            Expanded(child: Container()),
                            if (i == _selectedIndex)
                              UnderseaStyles.iconsFromImages("done", size: 28),
                            SizedBox(width: 20)
                          ],
                        )));
              });
        }),
      );
    else
      return AttackTabBar(() {
        setState(() {
          firstPage = true;
        });
      });
  }
}
