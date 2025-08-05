import 'dart:convert';
import 'dart:typed_data';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

/*
  |--------------------------------------------------------------------------
  | File: OCC Return Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling OCC return operations.
  | It manages the state and logic for OCC return requests.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-21
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Occ_Return_Controller extends GetxController {
  dynamic params = Get.arguments;

  final signatureKey = GlobalKey<SfSignaturePadState>();
  final remark = TextEditingController();
  Uint8List? signatureImg;

  final device = {}.obs;
  final feedback = {}.obs;
  final user = {}.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
    if (params['feedback'] != null) {
      feedback.value = params['feedback'];
    }
  }

  /// Sends a multipart/form-data POST request to return an OCC (Operational Control Center) item.
  ///
  /// This method performs the following steps:
  /// - Retrieves the user's authentication token.
  /// - Prepares a multipart request with required headers and fields:
  ///   - `request_user`: The user making the request.
  ///   - `request_id`: The ID of the OCC request.
  ///   - `remark`: Optional remark text if provided.
  ///   - `feedback`: Optional feedback, encoded as JSON if provided.
  ///   - `signature`: The user's signature image as a PNG file.
  /// - Sends the request to the OCC return API endpoint.
  /// - Waits for 2 seconds after receiving the response.
  /// - Returns `true` if the response status code is 200 (success), otherwise returns `false`.
  /// - In case of any exception, waits for 2 seconds and returns `false`.
  ///
  /// Returns:
  ///   `Future<bool>` indicating whether the OCC return was successful.
  Future<bool> returnOCC() async {
    String token = await UserPreferences().getToken();

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.occ_return),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['request_user'] = device['request_user'];
      request.fields['request_id'] = device['_id']['\$oid'];
      if (remark.text.isNotEmpty) {
        request.fields['remark'] = remark.text;
      }
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
