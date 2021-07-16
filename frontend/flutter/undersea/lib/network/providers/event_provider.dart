import 'package:get/get.dart';
import 'package:undersea/models/response/paged_result_of_event_dto.dart';

import '../network_provider.dart';

class EventProvider extends NetworkProvider {
  Future<Response<PagedResultOfEventDto>> getEventList(
          int pageSize, int pageNumber) =>
      get("/api/Event/user-events",
          contentType: 'application/json',
          query: {
            'PageNumber': '$pageNumber',
            'PageSize': '$pageSize',
          },
          decoder: (response) => PagedResultOfEventDto.fromJson(response));
}
