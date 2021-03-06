import 'package:get/get_connect/http/src/response/response.dart';

import '../../constants.dart';
import 'network_provider.dart';

class NextRoundProvider extends NetworkProvider {
  Future<Response<void>> nextRound() => post("/api/Round/call-next-round", {},
      contentType: 'application/json',
      headers: {'Authorization': 'Bearer ${storage.read(Constants.TOKEN)}'},
      decoder: (response) {});
}
