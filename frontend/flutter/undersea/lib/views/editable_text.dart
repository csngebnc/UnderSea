import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/styles/style_constants.dart';

class CityNameEditableText extends StatefulWidget {
  final String initialCityName;
  CityNameEditableText(this.initialCityName);
  @override
  _CityNameEditableTextState createState() =>
      new _CityNameEditableTextState(initialCityName);
}

class _CityNameEditableTextState extends State<CityNameEditableText> {
  _CityNameEditableTextState(this._cityName);
  String _cityName;
  bool _isEditingText = false;
  late TextEditingController _editingController;
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.city_name.tr,
              style: UnderseaStyles.whiteOpenSans
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            SizedBox(height: 5),
            _editableText(),
          ],
        ),
      ),
      Expanded(
        child: Container(),
      ),
      InkWell(
        onTap: () {
          setState(() {
            _editingController.text = _cityName;
            _isEditingText = true;
          });
        },
        child: UnderseaStyles.imageIcon("edit", color: Colors.white, size: 32),
      )
    ]);
  }

  Widget _editableText() {
    if (_isEditingText)
      return SizedBox(
          width: 150,
          child: TextField(
            decoration: InputDecoration(
                hintText: Strings.new_city_name.tr,
                hintStyle: UnderseaStyles.inputTextStyle
                    .copyWith(color: Colors.white54, fontSize: 17)),
            style: UnderseaStyles.whiteOpenSans
                .copyWith(fontWeight: FontWeight.normal, fontSize: 21),
            onSubmitted: (newValue) {
              setState(() {
                _cityName = newValue;
                _isEditingText = false;
              });

              Get.snackbar(Strings.city_modified_snack_title.tr,
                  Strings.city_modified_snack_body.tr + ': $_cityName',
                  icon: Icon(Icons.save_sharp),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.blueAccent);
            },
            autofocus: true,
            controller: _editingController,
          ));
    else
      return Text(
        _cityName,
        style: UnderseaStyles.whiteOpenSans.copyWith(fontSize: 21),
      );
  }

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: _cityName);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }
}
