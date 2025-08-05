import 'dart:convert';
import 'dart:typed_data';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

/*
  |--------------------------------------------------------------------------
  | File: Pilot Handover Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling pilot handover operations.
  | It manages the state and logic for pilot handover requests.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-20
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Pilot_Handover_Controller extends GetxController {
  dynamic params = Get.arguments;

  final signatureKey = GlobalKey<SfSignaturePadState>();
  Uint8List? signatureImg;

  final device = {}.obs;
  final feedback = {}.obs;
  final user = {}.obs;

  final message = ''.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
    if (params['feedback'] != null) {
      feedback.value = params['feedback'];
    }
  }

  /// Retrieves user information by user ID from the API.
  ///
  /// This method sends a GET request to the user endpoint with the provided [userId].
  /// It uses the stored authentication token for authorization. If the request is successful
  /// and the user data is found:
  /// - If [device['isFoRequest']] is `true`, it checks if the user's rank is 'FO' (First Officer).
  ///   If so, assigns the user data and returns `true`. Otherwise, sets an error message and returns `false`.
  /// - If [device['isFoRequest']] is `false`, assigns the user data and returns `true`.
  ///
  /// If the user is not found or the request fails, sets an appropriate error message and returns `false`.
  ///
  /// Returns a [Future] that completes with `true` if the user is found and valid for handover,
  /// otherwise `false`.
  ///
  /// [userId] - The ID of the user to retrieve.
  ///
  /// Throws no exceptions; returns `false` on error.
  Future<bool> getUser(String userId) async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_user_by_id,
        ).replace(queryParameters: {'id': userId}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final dynamic data = responseData['data'];
        if (data != null && data.isNotEmpty) {
          if (device['isFoRequest'] == true) {
            if (data[0]['rank'] == 'FO') {
              user.value = data[0];
              await Future.delayed(const Duration(seconds: 2));
              return true;
            } else {
              message.value = 'You can only handover to a First Officer.';
              return false;
            }
          } else {
            user.value = data[0];
            await Future.delayed(const Duration(seconds: 2));
            return true;
          }
        }

        await Future.delayed(const Duration(seconds: 2));
        message.value = 'User not found.';
        return false;
      } else {
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// Saves the pilot handover data by sending a multipart POST request to the server.
  ///
  /// This method performs the following steps:
  /// - Retrieves the authentication token from user preferences.
  /// - Constructs a multipart request with required headers and fields:
  ///   - `request_id`: The device request ID.
  ///   - `request_user`: The user who made the request.
  ///   - `handover_to`: The ID number of the user to whom the handover is made.
  ///   - `handover_date`: The current date and time.
  ///   - `feedback`: (optional) Encoded feedback data if available.
  ///   - `signature`: The signature image file.
  /// - Sends the request to the API endpoint specified in `ApiConfig.pilot_handover`.
  /// - Waits for 2 seconds after receiving the response.
  /// - Returns `true` if the response status code is 200 (success), otherwise returns `false`.
  /// - In case of any exception, waits for 2 seconds and returns `false`.
  ///
  /// Returns a [Future] that completes with a boolean indicating the success of the operation.
  Future<bool> saveHandover() async {
    String token = await UserPreferences().getToken();

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.pilot_handover),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['request_id'] = device['_id']['\$oid'];
      request.fields['request_user'] = device['request_user'];
      request.fields['handover_to'] = user['id_number'];
      request.fields['handover_date'] = DateTime.now().toString();
      if (feedback.isNotEmpty) {
        request.fields['feedback'] = jsonEncode(feedback);
      }
      request.files.add(
        http.MultipartFile.fromBytes(
          'signature',
          signatureImg!,
          filename: 'signature_${device['request_user']}.png',
          contentType: MediaType('image', 'png'),
        ),
      );

      final response = await request.send();

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
}
