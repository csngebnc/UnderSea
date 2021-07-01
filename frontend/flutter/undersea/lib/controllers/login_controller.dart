/*import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:undersea/constants.dart';
import 'package:undersea/network/providers/user_data_provider.dart';
import 'package:undersea/network/response/login_response.dart';
import 'package:undersea/views/bottom_nav_bar.dart';

class LoginController extends GetxController/* with StateMixin<LoginResponse>*/ {
  final LoginProvider _loginProvider;
  var storage = GetStorage();

  LoginController(this._loginProvider);

  login(String username, String password) async {
    //change(LoginResponse(), status: RxStatus.loading());
    try {
      var queryparams = {
        'username': 'sstrahan0',
        'password': 'Aa1234.',
        'grant_type': 'password',
        'client_id': 'undersea-angular',
        'scope': 'openid+api-openid'
      };
      final body =
          'username=$username&password=$password&grant_type=password&client_id=undersea-angular&scope=openid+api-openid';
      final response = await _loginProvider.login(body);
      if (response.body != null) {
        storage.write(Constants.TOKEN, response.body!.token);
        Get.off(BottomNavBar());
      }
    } catch (error) {
      Get.snackbar('Error', 'Bejelentkezési hiba');
      //change(RxList(), status: RxStatus.error("Hiba"));
    }
  }
}
*/