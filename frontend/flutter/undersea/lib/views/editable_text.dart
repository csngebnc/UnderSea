import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              'Városom neve',
              style: UnderseaStyles.inputTextStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
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
          child: Icon(
            Icons.mode_edit_outline_outlined,
            color: Colors.white,
            size: 30,
          ))
    ]);
  }

  Widget _editableText() {
    if (_isEditingText)
      return SizedBox(
          width: 150,
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Új városnév',
                hintStyle: UnderseaStyles.inputTextStyle.copyWith(
                    color: Colors.white54,
                    fontWeight: FontWeight.normal,
                    fontSize: 17)),
            style: UnderseaStyles.inputTextStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 21),
            onSubmitted: (newValue) {
              setState(() {
                _cityName = newValue;
                _isEditingText = false;
              });

              Get.snackbar(
                  'Városnév módosítva', 'A városod új neve: $_cityName',
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
        style: UnderseaStyles.inputTextStyle.copyWith(
            color: Colors.white, fontWeight: FontWeight.normal, fontSize: 21),
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