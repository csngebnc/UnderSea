import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/battle_data_controller.dart';
import 'package:undersea/models/response/logged_attack_dto.dart';
import 'package:undersea/styles/style_constants.dart';

class AttackHistoryPage extends StatefulWidget {
  @override
  _AttackHistoryPageState createState() => _AttackHistoryPageState();
}

class _AttackHistoryPageState extends State<AttackHistoryPage> {
  var controller = Get.find<BattleDataController>();

  final ScrollController _scrollController = ScrollController();
  List<LoggedAttackDto?> results = [];
  late int itemCount;
  @override
  void initState() {
    controller.attackLogPageNumber.value = 1;
    controller.alreadyDownloadedAttackLogPageNumber.value = 0;
    controller.attackLogsList.clear();
    controller.getHistory();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.attackLogPageNumber.value >
            controller.alreadyDownloadedAttackLogPageNumber.value) return;
        controller.attackLogPageNumber.value++;
        controller.getHistory();
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
              results = controller.attackLogsList.toList();
              itemCount =
                  controller.loadingList.value ? 1 : results.length * 2 + 1;
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int i) {
                    if (i == 0) {
                      return controller.loadingList.value
                          ? UnderseaStyles.listProgressIndicator()
                          : SizedBox(height: 10);
                    }
                    if (i.isEven) {
                      return UnderseaStyles.divider();
                    } else {
                      return _buildRow(i, results);
                    }
                  });
            })));
  }

  Widget _buildRow(int i, List<LoggedAttackDto?> attacks) {
    var actualAttack = attacks.elementAt(i ~/ 2);
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            (actualAttack?.attackedCountryName ?? '') +
                ' - ${UnderseaStyles.outcomeMap[actualAttack?.outcome]}',
            style: UnderseaStyles.listBold),
        ...actualAttack?.units
                ?.map((e) => Text(
                      '${e.name} (${e.level}): ${e.count}',
                      style: UnderseaStyles.listRegular.copyWith(height: 2),
                    ))
                .toList() ??
            [],
      ],
    );

    return Padding(padding: EdgeInsets.only(left: 20), child: column);
  }
}
