import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/event_data_controller.dart';
import 'package:undersea/models/response/event_dto.dart';
import 'package:undersea/styles/style_constants.dart';

class EventLogPage extends StatefulWidget {
  @override
  _EventLogPageState createState() => _EventLogPageState();
}

class _EventLogPageState extends State<EventLogPage> {
  var controller = Get.find<EventDataController>();
  late int itemCount;
  List<EventDto?> results = [];

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    //controller.alreadyDownloadedPageNumber.value = 0;
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
            decoration: BoxDecoration(color: UnderseaStyles.menuDarkBlue),
            child: GetBuilder<EventDataController>(builder: (controller) {
              results = controller.eventList.toList();
              itemCount =
                  controller.loadingList.value ? 1 : results.length * 2 + 1;
              return ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int i) {
                    if (i == 0) {
                      return controller.loadingList.value
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator()),
                              ),
                            )
                          : SizedBox(height: 10);
                    }
                    if (i.isEven) {
                      return UnderseaStyles.divider();
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
            color: UnderseaStyles.hintColor,
            borderRadius: BorderRadius.all(Radius.circular(32))),
        textStyle: UnderseaStyles.listRegular,
        showDuration: Duration(milliseconds: 500),
        message: event?.effects?.first.name ?? '-',
        child: ListTile(
            title: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            children: [
              Text(event?.name ?? '-',
                  style: UnderseaStyles.listBold.copyWith(fontSize: 16)),
              Expanded(
                child: Container(),
              ),
              Text('${event?.eventRound}. kör',
                  style: UnderseaStyles.listBold.copyWith(fontSize: 15))
            ],
          ),
        )));
  }
}
