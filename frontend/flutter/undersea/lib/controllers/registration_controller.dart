import 'package:get/get.dart';
import 'package:undersea/models/response/register_dto.dart';

import 'package:undersea/styles/style_constants.dart';

/*class RegistrationController extends GetxController
    with StateMixin<RegisterDto> {
  final RegistrationProvider __registrationProvider;

  RegistrationController(this.__registrationProvider);

  register(
      {required String username,
      required String password,
      required String confirmPassword,
      required String countryName,
      Function? onSuccess}) async {
    try {
      var registrationData = RegisterDto(
          userName: 'Cece1228',
          password: 'trOlOlO.1228',
          confirmPassword: 'trOlOlO.1228',
          countryName: 'Senkifölde');
      final response =
          await __registrationProvider.register(registrationData.toJson());
      if (response.statusCode == 200) onSuccess != null ? onSuccess() : {};
    } catch (error) {
      Get.snackbar('Error', 'Regisztrációs hiba');
      //change(RxList(), status: RxStatus.error("Hiba"));
    }
  }
}*/
