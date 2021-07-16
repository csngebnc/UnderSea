import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/battle_data_controller.dart';

import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/response/attackable_user_dto.dart';

import 'package:undersea/styles/style_constants.dart';

import 'attack_tabs/attack_tab_bar.dart';

class AttackPage extends StatefulWidget {
  @override
  _AttackPageState createState() => _AttackPageState();
}

class _AttackPageState extends State<AttackPage> {
  var controller = Get.find<BattleDataController>();
  final ScrollController _scrollController = ScrollController();

  int? _selectedIndex;
  var sliderValues = List<int>.generate(3, (index) => 0);
  var mercenaryPrice = 0;
  bool firstPage = true;
  late int itemCount;
  List<AttackableUserDto?> results = [];

  @override
  void initState() {
    controller.searchText.value = '';
    controller.alreadyDownloadedPageNumber.value = 0;
    controller.pageNumber.value = 1;
    controller.attackableUserList.clear();
    controller.getAttackableUsers();
    firstPage = true;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.pageNumber.value >
            controller.alreadyDownloadedPageNumber.value) return;
        controller.pageNumber.value++;
        controller.getAttackableUsers();
      }
    });
    controller.getAvailableUnits();
    controller.getUnitTypes();
    controller.getAllUnits();
    super.initState();
  }

  Widget? _itemBuilder(BuildContext ctx, int idx) {
    var user = results[idx];

    return Column(
      children: [
        UnderseaStyles.divider(),
        ListTile(
            visualDensity: VisualDensity(vertical: -4),
            onTap: () {
              setState(() {
                idx != _selectedIndex
                    ? _selectedIndex = idx
                    : _selectedIndex = null;
              });
              controller.countryToBeAttacked = _selectedIndex != null
                  ? controller.attackableUsers.value!.results![idx].countryId
                  : null;
            },
            title: Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 15, 0),
                child: Row(
                  children: [
                    SizedBox(
                        child: Text('${idx + 1}. ',
                            style: UnderseaStyles.listRegular),
                        width: 30),
                    SizedBox(width: 20),
                    Text(user?.userName ?? '',
                        style:
                            UnderseaStyles.listRegular.copyWith(fontSize: 16)),
                    Expanded(child: Container()),
                    if (idx == _selectedIndex)
                      UnderseaStyles.iconsFromImages("done", size: 28),
                    SizedBox(width: 20)
                  ],
                ))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (firstPage) {
      return UnderseaStyles.tabSkeleton(
        buttonText: Strings.proceed,
        isDisabled: _selectedIndex == null ? true : false,
        onButtonPressed: () {
          setState(() {
            firstPage = false;
          });
        },
        list: GetBuilder<BattleDataController>(builder: (controller) {
          results = controller.attackableUserList.toList();
          itemCount = results.length;

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: UnderseaStyles.menuDarkBlue,
                leadingWidth: 0,
                leading: Container(),
                toolbarHeight: controller.loadingList.value ? 150 : 100,
                title: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          UnderseaStyles.inputField(
                              hint: Strings.username.tr,
                              color: Color(0xFF657A9D),
                              hintColor: UnderseaStyles.alternativeHintColor,
                              onChanged: controller.onSearchChanged,
                              validator: (string) {}),
                          controller.loadingList.value
                              ? UnderseaStyles.listProgressIndicator(
                                  size: 30, padding: 10)
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  _itemBuilder,
                  childCount: itemCount,
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      results.isEmpty && !controller.loadingList.value
                          ? Text(Strings.no_user_named_this_way.tr,
                              style: UnderseaStyles.listRegular.copyWith(
                                  fontSize: 15,
                                  color: UnderseaStyles.underseaLogoColor))
                          : Container(),
                      SizedBox(
                          height: 20 + MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      );
    } else {
      return AttackTabBar(() {
        setState(() {
          firstPage = true;
        });
      });
    }
  }
}
