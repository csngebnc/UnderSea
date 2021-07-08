import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/battle_data_controller.dart';
import 'package:undersea/models/attack.dart';
import 'package:undersea/models/fight_outcome.dart';
import 'package:undersea/models/response/spy_report_dto.dart';
import 'package:undersea/styles/style_constants.dart';

class SpyingHistoryPage extends StatefulWidget {
  @override
  _SpyingHistoryPageState createState() => _SpyingHistoryPageState();
}

class _SpyingHistoryPageState extends State<SpyingHistoryPage> {
  var controller = Get.find<BattleDataController>();

  var outcomeMap = {
    FightOutcome.NotPlayedYet: 'Folyamatban',
    FightOutcome.CurrentUser: 'Győzelem',
    FightOutcome.OtherUser: 'Vereség'
  };
  final ScrollController _scrollController = ScrollController();
  List<SpyReportDto?> results = [];
  late int itemCount;
  @override
  void initState() {
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
            decoration: BoxDecoration(color: UnderseaStyles.menuDarkBlue),
            child: GetBuilder<BattleDataController>(builder: (controller) {
              results = controller.spyLogsList.value;
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: results.length * 2 + 1,
                  itemBuilder: (BuildContext context, int i) {
                    if (i == 0) return SizedBox(height: 20);
                    if (i.isEven)
                      return UnderseaStyles.divider();
                    else
                      return _buildRow(i, results);
                  });
            })));
  }

  Widget _buildRow(int i, List<SpyReportDto?> reportList) {
    var report = reportList.elementAt(i ~/ 2);
    var outcome = UnderseaStyles.outcomes[report?.outCome.index];
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(report?.spiedCountryName ?? '',
                    style: UnderseaStyles.listBold.copyWith(fontSize: 16)),
                Expanded(
                  child: Container(),
                ),
                Text('Védekezőerő',
                    style: UnderseaStyles.listBold.copyWith(fontSize: 15))
              ],
            ),
            Row(
              children: [
                Text(outcome!,
                    style: UnderseaStyles.listRegular.copyWith(height: 2)),
                Expanded(
                  child: Container(),
                ),
                Text('${report?.defensePoints ?? '?'}',
                    style: UnderseaStyles.listRegular.copyWith(
                      height: 2,
                    )),
              ],
            )
          ],
        ));
  }
}
