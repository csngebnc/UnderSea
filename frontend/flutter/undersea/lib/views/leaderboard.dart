import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/styles/style_constants.dart';
import 'package:undersea/views/attack_page.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({Key? key}) : super(key: key);

  late final Timer? _debounce;
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      Get.snackbar("Query changed", query,
          icon: Icon(Icons.app_registration),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blueAccent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UnderseaStyles.menuDarkBlue,
      appBar: AppBar(
        title: Text('Ranglista', style: UnderseaStyles.listBold),
        toolbarHeight: 85,
        backgroundColor: UnderseaStyles.hintColor,
        actions: [
          Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
              child: GestureDetector(
                  onTap: () {
                    Get.to(AttackPage());
                  },
                  child: SizedBox(
                    height: 40,
                    child: ShaderMask(
                      child: UnderseaStyles.imageIcon("tab_attack",
                          size: 30, color: UnderseaStyles.underseaLogoColor),
                      shaderCallback: (Rect bounds) {
                        final Rect rect = Rect.fromLTRB(0, 0, 30, 30);
                        return LinearGradient(
                                colors: UnderseaStyles.gradientColors,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)
                            .createShader(rect);
                      },
                    ),
                  ))),
        ],
      ),
      body: ListView.builder(
          itemCount: 50,
          itemBuilder: (BuildContext context, int i) {
            if (i.isOdd) return UnderseaStyles.divider();
            if (i == 0) {
              return Padding(
                padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: UnderseaStyles.inputField(
                    hint: 'Felhasználónév',
                    color: Color(0xFF657A9D),
                    hintColor: UnderseaStyles.alternativeHintColor,
                    onChanged: _onSearchChanged),
              );
            }
            return Padding(
                padding: EdgeInsets.fromLTRB(35, 10, 15, 10),
                child: Row(
                  children: [
                    SizedBox(
                        child: Text('${i ~/ 2}. ',
                            style: UnderseaStyles.listRegular),
                        width: 30),
                    SizedBox(width: 20),
                    Text('kiscsiko98', style: UnderseaStyles.listRegular)
                  ],
                ));
          }),
    );
  }
}
