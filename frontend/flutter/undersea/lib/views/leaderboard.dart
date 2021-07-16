import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';
import 'package:undersea/models/response/user_rank_dto.dart';
import 'package:undersea/services/navbar_controller.dart';
import 'package:undersea/services/user_service.dart';
import 'package:undersea/widgets/image_icon.dart';
import 'package:undersea/widgets/input_field.dart';
import 'package:undersea/widgets/us_divider.dart';
import 'package:undersea/widgets/us_progress_indicator.dart';

class Leaderboard extends StatefulWidget {
  Leaderboard({Key? key}) : super(key: key);

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final BottomNavBarController navbarcontroller =
      Get.find<BottomNavBarController>();
  var controller = Get.find<UserService>();
  late int itemCount;
  List<UserRankDto?> results = [];

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    controller.searchText.value = '';
    controller.alreadyDownloadedPageNumber.value = 0;
    controller.pageNumber.value = 1;
    controller.rankList.clear();
    controller.getRankList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.pageNumber.value >
            controller.alreadyDownloadedPageNumber.value) return;
        controller.pageNumber.value++;
        controller.getRankList();
      }
    });
    super.initState();
  }

  Widget? _itemBuilder(BuildContext ctx, int idx) {
    var user = results[idx];

    return Column(
      children: [
        USDivider(),
        Padding(
            padding: EdgeInsets.fromLTRB(35, 10, 15, 10),
            child: Row(
              children: [
                SizedBox(
                    child:
                        Text('${user?.placement}. ', style: USText.listRegular),
                    width: 30),
                SizedBox(width: 20),
                Text(user?.name ?? '', style: USText.listRegular),
                Expanded(child: Container()),
                Text(user?.points.toString() ?? '', style: USText.listRegular)
              ],
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: USColors.menuDarkBlue,
      appBar: AppBar(
        title: Text(Strings.leaderboard.tr, style: USText.listBold),
        toolbarHeight: 85,
        backgroundColor: USColors.hintColor,
        actions: [
          Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                    navbarcontroller.selectedTab.value = 2;
                  },
                  child: SizedBox(
                    height: 40,
                    child: ShaderMask(
                      child: USImageIcon(
                          assetName: "tab_attack",
                          size: 30,
                          color: USColors.underseaLogoColor),
                      shaderCallback: (Rect bounds) {
                        final Rect rect = Rect.fromLTRB(0, 0, 30, 30);
                        return LinearGradient(
                                colors: USColors.gradientColors,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)
                            .createShader(rect);
                      },
                    ),
                  ))),
        ],
      ),
      body: GetBuilder<UserService>(builder: (controller) {
        results = controller.rankList.toList();
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
  }
}
