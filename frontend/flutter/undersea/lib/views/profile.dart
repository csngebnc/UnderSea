import 'package:flutter/material.dart';
import 'package:undersea/styles/style_constants.dart';

class ProfilePage extends StatelessWidget {
  final String cityName;
  final String playerName;

  ProfilePage({required this.cityName, required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03255F),
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Color(0xFF1C3E76),
      ),
      body: Column(children: [
        Center(
            child: Column(children: [
          SizedBox(
            height: 40,
          ),
          UnderseaStyles.assetIcon("profile", iconSize: 70),
          SizedBox(
            height: 25,
          ),
          Text(playerName,
              style: UnderseaStyles.inputTextStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21)),
          SizedBox(
            height: 10,
          ),
          UnderseaStyles.divider(),
          SizedBox(
            height: 10,
          ),
        ])),
        Align(
            alignment: Alignment.centerLeft,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Városom neve',
                              style: UnderseaStyles.inputTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21),
                            ),
                            Text(
                              cityName,
                              style: UnderseaStyles.inputTextStyle
                                  .copyWith(color: Colors.white, fontSize: 21),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Icon(
                        Icons.mode_edit_outline_outlined,
                        color: Colors.white,
                        size: 30,
                      )
                    ]),
              ),
              UnderseaStyles.divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextButton(
                    onPressed: () {
                      //logout
                    },
                    child: Text('Kijelentkezés',
                        style: UnderseaStyles.buttonTextStyle
                            .copyWith(color: UnderseaStyles.underseaLogoColor)),
                  ),
                ),
              ),
              UnderseaStyles.divider()
            ]))
      ]),
    );
  }
}
