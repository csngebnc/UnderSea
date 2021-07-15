import 'dart:developer';

import 'package:get/get.dart';
import 'package:undersea/models/response/event_dto.dart';
import 'package:undersea/models/response/paged_result_of_event_dto.dart';
import 'package:undersea/network/providers/event_provider.dart';

class EventDataController extends GetxController {
  final EventProvider _eventProvider;

  Rx<bool> loadingList = false.obs;

  EventDataController(this._eventProvider);

  Rx<PagedResultOfEventDto?> pagedEventList = Rx(null);

  var pageNumber = 1.obs;
  var alreadyDownloadedPageNumber = 0.obs;
  var pageSize = 10.obs;
  var eventList = <EventDto>[].obs;

  getEventList() async {
    loadingList = true.obs;
    update();
    try {
      if (pagedEventList.value != null &&
          pagedEventList.value!.allResultsCount <
              alreadyDownloadedPageNumber.value * pageSize.value) return;
      final response =
          await _eventProvider.getEventList(pageSize.value, pageNumber.value);
      if (response.statusCode == 200) {
        pagedEventList = Rx(response.body!);
        if (alreadyDownloadedPageNumber.value !=
            pagedEventList.value!.pageNumber) {
          eventList.value += pagedEventList.value?.results ?? [];
          alreadyDownloadedPageNumber.value = pageNumber.value;
        }
        //update();
      }
    } catch (error) {
      log('$error');
    } finally {
      loadingList = false.obs;
      update();
    }
  }

  void reset() {
    pagedEventList = Rx(null);
    pageNumber.value = 1;
    alreadyDownloadedPageNumber.value = 0;
    pageSize.value = 10;
    eventList.clear();
  }
}
