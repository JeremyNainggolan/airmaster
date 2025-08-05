import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: FO Waiting Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling FO Waiting operations.
  | It manages the state and logic for waiting confirmation requests.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-07
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Waiting_Controller extends GetxController {
  dynamic params = Get.arguments;

  final device = {}.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }

  /// Cancels a device request by sending a DELETE HTTP request to the API.
  ///
  /// Retrieves the user's authentication token and constructs the request URL
  /// with the required query parameters: `request_id`, `mainDeviceNo`, and `backupDeviceNo`.
  ///
  /// Returns `true` if the cancellation is successful (HTTP 200), otherwise returns `false`.
  /// If an exception occurs during the request, returns `false`.
  ///
  /// Throws no exceptions.
  ///
  /// Example usage:
  /// ```dart
  /// bool success = await cancelRequest();
  /// ```
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
