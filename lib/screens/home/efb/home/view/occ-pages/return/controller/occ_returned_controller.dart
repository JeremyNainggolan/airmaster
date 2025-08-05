import 'dart:developer';
import 'dart:typed_data';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

/*
  |--------------------------------------------------------------------------
  | File: OCC Returned Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling OCC returned device operations.
  | It manages the state and logic for returning devices, including capturing
  | signatures and images.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-09
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class OCC_Returned_Controller extends GetxController {
  dynamic params = Get.arguments;

  final device = {}.obs;

  final category = 'Good'.obs;
  final remark = ''.obs;

  final signatureKey = GlobalKey<SfSignaturePadState>();
  Uint8List? signatureImg;
  Uint8List? returnedDeviceImg;

  final isCaptured = false.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }

  /// Captures an image using the device camera and updates the state.
  ///
  /// This method uses the [ImagePicker] to open the camera and allows the user to take a photo.
  /// If an image is captured, it toggles the [isCaptured] value and stores the image bytes
  /// in [returnedDeviceImg].
  ///
  /// Throws no exceptions but does nothing if the user cancels the camera operation.
  Future<void> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      isCaptured.value = !isCaptured.value;
      returnedDeviceImg = await image.readAsBytes();
    }
  }

  /// Sends a multipart POST request to confirm the return of an OCC device.
  ///
  /// This method gathers necessary user and device information, attaches images
  /// (signature and returned device), and sends them to the server. It handles
  /// both FO and non-FO requests by including appropriate fields.
  ///
  /// Returns `true` if the request was successful (HTTP 200), otherwise returns `false`.
  ///
  /// Throws and logs any errors encountered during the request.
  ///
  /// Fields sent:
  /// - `request_id`: The device request ID.
  /// - `received_at`: The current timestamp.
  /// - `received_by`: The user ID of the receiver.
  /// - `category`: The category of the device.
  /// - `remark`: Any additional remarks.
  /// - `isFoRequest`: Whether the request is an FO request.
  /// - `mainDeviceNo` and `backupDeviceNo`: Included if FO request.
  /// - `deviceno`: Included if not FO request.
  ///
  /// Files sent:
  /// - `signature`: The signature image.
  /// - `returned_device`: The returned device image.
  ///
  /// Headers:
  /// - `Authorization`: Bearer token for authentication.
  /// - `Content-Type`: multipart/form-data.
  Future<bool> returnOCC() async {
    String token = await UserPreferences().getToken();
    String userId = await UserPreferences().getIdNumber();

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.confirm_return),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['request_id'] = device['_id']['\$oid'];
      request.fields['received_at'] = DateTime.now().toString();
      request.fields['received_by'] = userId;
      request.fields['category'] = category.value;
      request.fields['remark'] = remark.value;
      request.fields['isFoRequest'] = device['isFoRequest'].toString();

      if (device['isFoRequest']) {
        request.fields['mainDeviceNo'] = device['mainDeviceNo'];
        request.fields['backupDeviceNo'] = device['backupDeviceNo'];
      } else {
        request.fields['deviceno'] = device['deviceno'];
      }

      request.files.add(
        http.MultipartFile.fromBytes(
          'signature',
          signatureImg!,
          filename: 'signature_${device['request_user']}.png',
          contentType: MediaType('image', 'png'),
        ),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'returned_device',
          returnedDeviceImg!,
          filename: 'return_device_${device['deviceno']}.png',
          contentType: MediaType('image', 'png'),
        ),
      );

      final response = await request.send();

      log('Response Body: ${await response.stream.bytesToString()}');

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 2));
      log('Error: $e');
      return false;
    }
  }
}
