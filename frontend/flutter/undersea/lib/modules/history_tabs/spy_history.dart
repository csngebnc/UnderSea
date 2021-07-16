import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/constants.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';
import 'package:undersea/models/response/spy_report_dto.dart';
import 'package:undersea/services/battle_service.dart';
import 'package:undersea/widgets/us_divider.dart';
import 'package:undersea/widgets/us_progress_indicator.dart';

class SpyingHistoryPage extends StatefulWidget {
  @override
  _SpyingHistoryPageState createState() => _SpyingHistoryPageState();
}

class _SpyingHistoryPageState extends State<SpyingHistoryPage> {
  var controller = Get.find<BattleService>();

  final ScrollController _scrollController = ScrollController();
  List<SpyReportDto?> results = [];
  late int itemCount;
  @override
  void initState() {
    controller.loadingList = false.obs;
    controller.spyLogPageNumber.value = 1;
    controller.alreadyDownloadedSpyLogPageNumber.value = 0;
    controller.spyLogsList.clear();
    controller.getSpyingHistory();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.spyLogPageNumber.value >
            controller.alreadyDownloadedSpyLogPageNumber.value) return;
        controller.spyLogPageNumber.value++;
        controller.getSpyingHistory();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: BoxDecoration(color: USColors.menuDarkBlue),
            child: GetBuilder<BattleService>(builder: (controller) {
              results = controller.spyLogsList.toList();
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: results.length * 2 + 1,
                  itemBuilder: (BuildContext context, int i) {
                    if (i == 0) {
                      return controller.loadingList.value
                          ? USProgressIndicator()
                          : results.isEmpty
                              ? Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Text(Strings.no_element.tr,
                                        style: USText.listBold
                                            .copyWith(fontSize: 13)),
                                  ],
                                )
                              : SizedBox(height: 10);
                    }
                    if (i.isEven) {
                      return USDivider();
                    } else {
                      return _buildRow(i, results);
                    }
                  });
            })));
  }

  Widget _buildRow(int i, List<SpyReportDto?> reportList) {
    var report = reportList.elementAt(i ~/ 2);
    var outcome = Constants.outcomeMap[report?.outCome];
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(report?.spiedCountryName ?? '',
                    style: USText.listBold.copyWith(fontSize: 16)),
                Expanded(
                  child: Container(),
                ),
                Text(Strings.defense_points.tr,
                    style: USText.listBold.copyWith(fontSize: 15))
              ],
            ),
            Row(
              children: [
                Text(outcome!, style: USText.listRegular.copyWith(height: 2)),
                Expanded(
                  child: Container(),
                ),
                Text('${report?.defensePoints ?? '?'}',
                    style: USText.listRegular.copyWith(
                      height: 2,
                    )),
              ],
            )
          ],
        ));
  }
}
