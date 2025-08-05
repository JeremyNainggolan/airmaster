import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: OCC Requested Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling OCC requested operations.
  | It manages the state and logic for OCC requested requests, including
  | fetching details, approving, and rejecting requests.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-04
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class OCC_Requested_Controller extends GetxController {
  dynamic params = Get.arguments;

  final device = {}.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }

  /// Rejects a device request by sending an HTTP GET request to the API.
  ///
  /// The method determines the request type based on the `device['isFoRequest']` flag.
  /// It constructs the appropriate query parameters and sends the request with authorization headers.
  /// Returns `true` if the rejection is successful (HTTP 200), otherwise returns `false`.
  /// In case of an error or non-200 response, it also returns `false`.
  ///
  /// Adds a 2-second delay after the request, regardless of the outcome.
  ///
  /// Throws no exceptions; all errors are caught and handled internally.
  ///
  /// Returns:
  ///   - `Future<bool>`: `true` if the request was rejected successfully, `false` otherwise.
  Future<bool> reject() async {
    String token = await UserPreferences().getToken();
    String userId = await UserPreferences().getIdNumber();

    try {
      var response = http.Response('', 500); // Initialize response
      if (device['isFoRequest']) {
        response = await http.get(
          Uri.parse(ApiConfig.reject_request_device).replace(
            queryParameters: {
              'isFoRequest': device['isFoRequest'].toString(),
              'request_id': device['_id']['\$oid'],
              'rejected_by': userId,
              'rejected_at': DateTime.now().toString(),
              'mainDeviceNo': device['mainDeviceNo'],
              'backupDeviceNo': device['backupDeviceNo'],
            },
          ),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );
      } else {
        response = await http.get(
          Uri.parse(ApiConfig.reject_request_device).replace(
            queryParameters: {
              'isFoRequest': device['isFoRequest'].toString(),
              'request_id': device['_id']['\$oid'],
              'rejected_by': userId,
              'rejected_at': DateTime.now().toString(),
              'deviceno': device['deviceno'],
            },
          ),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );
      }

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 2));
      return false;
    }
  }

  /// Approves a device request by sending a POST request to the API.
  ///
  /// Retrieves the user's token and ID number from preferences, then sends
  /// the approval details to the server. Logs the response and returns `true`
  /// if the approval was successful (HTTP 200), otherwise returns `false`.
  /// In case of an error, logs the error and returns `false`.
  ///
  /// Returns a [Future] that completes with a [bool] indicating success or failure.
  Future<bool> approve() async {
    String token = await UserPreferences().getToken();
    String userId = await UserPreferences().getIdNumber();

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.approve_request_device),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'request_id': device['_id']['\$oid'],
          'approved_by': userId,
          'approved_at': DateTime.now().toString(),
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        log('Failed to fetch devices: ${response.statusCode}');
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }
    } catch (e) {
      log('Error: $e');
      await Future.delayed(const Duration(seconds: 2));
      return false;
    }
  }
}
