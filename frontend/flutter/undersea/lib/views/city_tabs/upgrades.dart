import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/models/upgrade.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:get/get.dart';

class Upgrades extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var upgradeList = <Upgrade>[
      Upgrade(
        availableIn: 3,
        name: "Iszaptraktor",
        imageName: "iszaptraktor",
        effect: "növeli a krumpli termesztést 10%-kal",
        isAvailable: true,
        isInProgress: false,
      ),
      Upgrade(
        availableIn: 3,
        name: "Iszapkombájn",
        imageName: "iszapkombajn",
        effect: "növeli a krumpli termesztést 15%-kal",
        isAvailable: true,
        isInProgress: false,
      ),
      Upgrade(
        availableIn: 5,
        name: "Korallfal",
        imageName: "korallfal",
        effect: "növeli a védelmi pontokat 20%-kal",
        isAvailable: false,
        isInProgress: true,
      ),
      Upgrade(
        availableIn: 3,
        name: "Szonárágyú",
        imageName: "szonaragyu",
        effect: "növeli a támadópontokat 20%-kal",
        isAvailable: false,
        isInProgress: false,
      ),
      Upgrade(
        availableIn: 3,
        name: "Vízalatti harcművészetek",
        imageName: "vizicsillag",
        effect: "növeli a védelmi és támadóerőt 10%-kal",
        isAvailable: false,
        isInProgress: false,
      ),
      Upgrade(
        availableIn: 3,
        name: "Alkímia",
        imageName: "alkimia",
        effect: "növeli a beszedett adót 30%-kal",
        isAvailable: false,
        isInProgress: false,
      ),
    ];

    return UnderseaStyles.tabSkeleton(
        list: ListView.builder(
            itemCount: 8,
            itemBuilder: (BuildContext context, int i) {
              if (i == 0)
                return UnderseaStyles.infoPanel(
                    Strings.upgrades_manual_title.tr,
                    Strings.upgrades_manual_hint.tr);
              if (i > upgradeList.length) return SizedBox(height: 100);

              return _buildRow(i, upgradeList);
            }));
  }

  Widget _buildRow(int index, List<Upgrade> list) {
    var actualUpgrade = list[index - 1];
    return ListTile(
        title: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: UnderseaStyles.buildingImage(
                                  actualUpgrade.imageName + '@3x'),
                            ),
                            Text(actualUpgrade.name,
                                style: UnderseaStyles.listBold,
                                textAlign: TextAlign.center),
                            Text(
                              actualUpgrade.effect,
                              style: UnderseaStyles.listRegular,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      actualUpgrade.isAvailable
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.done_outline_sharp,
                                color: UnderseaStyles.underseaLogoColor,
                              ))
                          : Container(),
                      actualUpgrade.isInProgress
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'még ${actualUpgrade.availableIn} kör',
                                style: TextStyle(
                                    color: UnderseaStyles.underseaLogoColor,
                                    fontSize: 16),
                              ))
                          : Container(),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: UnderseaStyles.hintColor)))));
  }
}
