import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';
import 'package:undersea/models/response/attackable_user_dto.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/widgets/circle_button.dart';
import 'package:undersea/widgets/input_field.dart';
import 'package:undersea/widgets/tab_skeleton.dart';
import 'package:undersea/widgets/us_divider.dart';
import 'package:undersea/widgets/us_progress_indicator.dart';

import 'attack_tabs/attack_tab_bar.dart';

class AttackPage extends StatefulWidget {
  @override
  _AttackPageState createState() => _AttackPageState();
}

class _AttackPageState extends State<AttackPage> {
  var controller = Get.find<BattleService>();
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
        USDivider(),
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
                        child: Text('${idx + 1}. ', style: USText.listRegular),
                        width: 30),
                    SizedBox(width: 20),
                    Text(user?.userName ?? '',
                        style: USText.listRegular.copyWith(fontSize: 16)),
                    Expanded(child: Container()),
                    if (idx == _selectedIndex)
                      CircleButton.iconsFromImages("done", size: 28),
                    SizedBox(width: 20)
                  ],
                ))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (firstPage) {
      return TabSkeleton(
        buttonText: Strings.proceed.tr,
        isDisabled: _selectedIndex == null ? true : false,
        onButtonPressed: () {
          setState(() {
            firstPage = false;
          });
        },
        list: GetBuilder<BattleService>(builder: (controller) {
          results = controller.attackableUserList.toList();
          itemCount = results.length;

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: USColors.menuDarkBlue,
                leadingWidth: 0,
                leading: Container(),
                toolbarHeight: controller.loadingList.value ? 150 : 100,
                title: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          InputField(
                            hint: Strings.username.tr,
                            color: Color(0xFF657A9D),
                            hintColor: USColors.alternativeHintColor,
                            onChanged: controller.onSearchChanged,
                          ),
                          controller.loadingList.value
                              ? USProgressIndicator(size: 30, padding: 10)
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
                              style: USText.listRegular.copyWith(
                                  fontSize: 15,
                                  color: USColors.underseaLogoColor))
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
