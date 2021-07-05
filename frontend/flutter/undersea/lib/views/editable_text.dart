import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/country_data_controller.dart';
import 'package:undersea/lang/strings.dart';
import 'package:undersea/styles/style_constants.dart';

class CityNameEditableText extends StatefulWidget {
  CityNameEditableText();

  @override
  _CityNameEditableTextState createState() => new _CityNameEditableTextState();
}

class _CityNameEditableTextState extends State<CityNameEditableText> {
  _CityNameEditableTextState();

  @override
  void initState() {
    controller.getCountryName();
    _editingController =
        TextEditingController(text: controller.countryName.value);
    super.initState();
  }

  bool _isEditingText = false;
  final controller = Get.find<CountryDataController>();
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
      GetBuilder<CountryDataController>(builder: (controller) {
        final countryName = controller.countryName.value;
        if (countryName != null)
          return InkWell(
            onTap: () {
              setState(() {
                _editingController.text = countryName;
                _isEditingText = true;
              });
            },
            child:
                UnderseaStyles.imageIcon("edit", color: Colors.white, size: 32),
          );
        else
          return InkWell(
            onTap: () {
              setState(() {
                _editingController.text = 'default';
                _isEditingText = true;
              });
            },
            child:
                UnderseaStyles.imageIcon("edit", color: Colors.white, size: 32),
          );
      }),
      /*InkWell(
        onTap: () {
          setState(() {
            _editingController.text = controller.countryName.value ?? 'default';
            _isEditingText = true;
          });
        },
        child: UnderseaStyles.imageIcon("edit", color: Colors.white, size: 32),
      )*/
    ]);
  }

  Widget _editableText() {
    if (_isEditingText)
      return SizedBox(
          width: 150,
          height: 60,
          child: Align(
              alignment: Alignment.centerLeft,
              child: TextField(
                decoration: InputDecoration(
                    hintText: Strings.new_city_name.tr,
                    hintStyle: UnderseaStyles.inputTextStyle
                        .copyWith(color: Colors.white54, fontSize: 17)),
                style: UnderseaStyles.whiteOpenSans
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 21),
                onSubmitted: (newValue) {
                  setState(() {
                    _isEditingText = false;
                  });
                  controller.setCountryName(newValue);
                },
                autofocus: true,
                controller: _editingController,
              )));
    else
      return SizedBox(
          width: 150,
          height: 40,
          child: Align(
              alignment: Alignment.centerLeft,
              child:
                  /*Text(
                controller.countryName.value ?? 'default',
                style: UnderseaStyles.whiteOpenSans.copyWith(fontSize: 21),
              ))*/
                  GetBuilder<CountryDataController>(builder: (controller) {
                final countryName = controller.countryName.value;
                if (countryName != null)
                  return Text(
                    countryName,
                    style: UnderseaStyles.whiteOpenSans.copyWith(fontSize: 21),
                  );
                /*else if (snapshot.hasError)
                      return Text('error',
                          style: UnderseaStyles.inputTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21));*/
                else
                  return Text(
                    'default',
                    style: UnderseaStyles.whiteOpenSans.copyWith(fontSize: 21),
                  );
              })));
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }
}
