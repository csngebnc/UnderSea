import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';
import 'package:undersea/views/leaderboard.dart';

class LeaderboardButton extends StatelessWidget {
  const LeaderboardButton({Key? key, this.roundNumber, this.placement})
      : super(key: key);

  final int? roundNumber;
  final int? placement;

  Widget _leaderboardText(int number, String text) {
    return Expanded(
        child: Align(
            alignment: Alignment.center,
            child: Text(
              number.toString() + text,
              style: USText.buttonTextStyle.copyWith(
                  color: USColors.hintColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 180,
        child: ElevatedButton(
          onPressed: () {
            Get.to(Leaderboard());
          },
          child: roundNumber == null && placement == null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox(
                        child: CircularProgressIndicator(),
                        height: 30,
                        width: 30),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.fromLTRB(5, 7, 5, 5),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(children: [
                        _leaderboardText(roundNumber!, Strings.round.tr),
                        _leaderboardText(placement!, Strings.placement.tr),
                      ]))),
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: EdgeInsets.all(5),
              elevation: 10,
              shadowColor: USColors.shadowColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
        ),
      ),
    );
  }
}
