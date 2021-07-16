import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/core/lang/strings.dart';
import 'package:undersea/core/theme/colors.dart';
import 'package:undersea/core/theme/text_styles.dart';
import 'package:undersea/models/response/event_dto.dart';
import 'package:undersea/services/event_service.dart';
import 'package:undersea/widgets/us_divider.dart';
import 'package:undersea/widgets/us_progress_indicator.dart';

class EventLogPage extends StatefulWidget {
  @override
  _EventLogPageState createState() => _EventLogPageState();
}

class _EventLogPageState extends State<EventLogPage> {
  var controller = Get.find<EventService>();
  late int itemCount;
  List<EventDto?> results = [];

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    controller.loadingList = false.obs;
    controller.pageNumber.value = 1;
    controller.alreadyDownloadedPageNumber.value = 0;
    controller.eventList.clear();

    controller.getEventList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.pageNumber.value >
            controller.alreadyDownloadedPageNumber.value) return;
        controller.pageNumber.value++;
        controller.getEventList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: BoxDecoration(color: USColors.menuDarkBlue),
            child: GetBuilder<EventService>(builder: (controller) {
              results = controller.eventList.toList();
              itemCount =
                  controller.loadingList.value ? 1 : results.length * 2 + 1;
              return ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int i) {
                    if (i == 0) {
                      return controller.loadingList.value
                          ? USProgressIndicator()
                          : results.isEmpty
                              ? Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Text(Strings.no_element.tr,
                                        style: USText.listBold
                                            .copyWith(fontSize: 13)),
                                  ],
                                )
                              : SizedBox(height: 10);
                    }
                    if (i.isEven) {
                      return USDivider();
                    } else {
                      return _buildRow(i);
                    }
                  });
            })));
  }

  Widget _buildRow(int i) {
    var event = results.elementAt(i ~/ 2);

    return Tooltip(
        decoration: BoxDecoration(
            color: USColors.hintColor,
            borderRadius: BorderRadius.all(Radius.circular(32))),
        textStyle: USText.listRegular,
        showDuration: Duration(milliseconds: 500),
        message: event?.effects?.first.name ?? '-',
        child: ListTile(
            title: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            children: [
              Text(event?.name ?? '-',
                  style: USText.listBold.copyWith(fontSize: 16)),
              Expanded(
                child: Container(),
              ),
              Text('${event?.eventRound}. kör',
                  style: USText.listBold.copyWith(fontSize: 15))
            ],
          ),
        )));
  }
}
