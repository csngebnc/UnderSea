import 'package:flutter/material.dart';
import 'package:undersea/models/attack.dart';
import 'package:undersea/styles/style_constants.dart';

class MyArmyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var attackList = <AttackDetails>[
      AttackDetails(
          targetedCity: "Atlantisz",
          soldiers: <String, int>{
            'Lézercápa': 6,
            'Rohamfóka': 5,
            'Csatacsikó': 32
          },
          winnerPlayerName: "Winner Player"),
      AttackDetails(
          targetedCity: "Atlantisz 2",
          soldiers: <String, int>{
            'Lézercápa': 6,
            'Rohamfóka': 5,
            'Csatacsikó': 32
          },
          winnerPlayerName: "Winner Player"),
      AttackDetails(
          targetedCity: "Atlantisz 3",
          soldiers: <String, int>{
            'Lézercápa': 6,
            'Rohamfóka': 5,
            'Csatacsikó': 32
          },
          winnerPlayerName: "Winner Player"),
      AttackDetails(
          targetedCity: "Atlantisz 4",
          soldiers: <String, int>{
            'Lézercápa': 6,
            'Rohamfóka': 5,
            'Csatacsikó': 32
          },
          winnerPlayerName: "Winner Player"),
    ];

    return Expanded(
        child: Container(
            decoration: BoxDecoration(color: UnderseaStyles.menuDarkBlue),
            child: ListView.builder(
                itemCount: attackList.length * 2 + 1,
                itemBuilder: (BuildContext context, int i) {
                  if (i.isEven)
                    return UnderseaStyles.divider();
                  else
                    return _buildRow(i, attackList);
                })));
  }

  Widget _buildRow(int i, List<AttackDetails> attacks) {
    var actualAttack = attacks.elementAt(i ~/ 2);
    var column = Column(
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

    return Padding(padding: EdgeInsets.only(left: 20), child: column);
  }
}
