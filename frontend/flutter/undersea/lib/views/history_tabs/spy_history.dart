import 'package:flutter/material.dart';
import 'package:undersea/models/attack.dart';
import 'package:undersea/models/fight_outcome.dart';
import 'package:undersea/models/response/spy_report_dto.dart';
import 'package:undersea/styles/style_constants.dart';

class SpyingHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var spyReportList = <SpyReportDto>[
      SpyReportDto(
          outCome: FightOutcome.NotPlayedYet,
          spyReportId: 1,
          defensePoints: null,
          spiedCountryName: 'Atlantisz'),
      SpyReportDto(
          outCome: FightOutcome.CurrentUser,
          spyReportId: 2,
          defensePoints: 260,
          spiedCountryName: 'Atalantisz'),
      SpyReportDto(
          outCome: FightOutcome.OtherUser,
          spyReportId: 3,
          defensePoints: null,
          spiedCountryName: 'Ausztrália'),
      SpyReportDto(
          outCome: FightOutcome.CurrentUser,
          spyReportId: 4,
          defensePoints: 800,
          spiedCountryName: 'Óceánia'),
    ];

    return Expanded(
        child: Container(
            decoration: BoxDecoration(color: UnderseaStyles.menuDarkBlue),
            child: ListView.builder(
                itemCount: spyReportList.length * 2 + 1,
                itemBuilder: (BuildContext context, int i) {
                  if (i == 0) return SizedBox(height: 20);
                  if (i.isEven)
                    return UnderseaStyles.divider();
                  else
                    return _buildRow(i, spyReportList);
                })));
  }

  Widget _buildRow(int i, List<SpyReportDto> reportList) {
    var report = reportList.elementAt(i ~/ 2);
    var outcome = UnderseaStyles.outcomes[report.outCome.index];
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(report.spiedCountryName!,
                    style: UnderseaStyles.listBold.copyWith(fontSize: 20)),
                Expanded(
                  child: Container(),
                ),
                Text('Védekezőerő',
                    style: UnderseaStyles.listBold.copyWith(fontSize: 17))
              ],
            ),
            Row(
              children: [
                Text(outcome!,
                    style: UnderseaStyles.listRegular
                        .copyWith(height: 2, fontSize: 20)),
                Expanded(
                  child: Container(),
                ),
                Text('${report.defensePoints ?? '?'}',
                    style: UnderseaStyles.listRegular
                        .copyWith(height: 2, fontSize: 20)),
              ],
            )
          ],

          /*Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text('kimenetel',
                style: UnderseaStyles.listRegular
                    .copyWith(height: 2, fontSize: 20)),
          ],
        )
      ],
    );*/
          /* var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(actualAttack.targetedCity,
            style: UnderseaStyles.listBold.copyWith(fontSize: 20)),
      ],
    );
    actualAttack.soldiers.forEach((key, value) {
      column.children.add(Text(
        '$value $key',
        style: UnderseaStyles.listRegular.copyWith(height: 2, fontSize: 20),
      ));
    });

    return Padding(padding: EdgeInsets.only(left: 20), child: column);*/
        ));
  }
}
