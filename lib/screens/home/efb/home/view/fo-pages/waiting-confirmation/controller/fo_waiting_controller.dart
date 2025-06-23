import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Fo_Waiting_Controller extends GetxController {
  dynamic params = Get.arguments;

  final device = {}.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }

  Future<bool> cancelRequest() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.delete(
        Uri.parse(ApiConfig.cancel_request).replace(
          queryParameters: {
            'request_id': device['_id']['\$oid'],
            'mainDeviceNo': device['mainDeviceNo'],
            'backupDeviceNo': device['backupDeviceNo'],
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
