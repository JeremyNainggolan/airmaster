import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:airmaster/config/api_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

/*
  |--------------------------------------------------------------------------
  | File: Accept Handover Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for accepting handover requests.
  | It manages the state and logic for accepting device handovers.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-04-24
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Accept_Handover_Controller extends GetxController {
  // Parameters passed to the controller
  dynamic params = Get.arguments;

  // Observable variables for managing state
  final requestId = ''.obs;
  final isLoading = false.obs;

  // Observable variable for storing handover details
  final detail = {}.obs;

  // Controllers for text fields
  final isCaptured = false.obs;
  final category = 'Good'.obs;
  final categoryRemark = ''.obs;
  final damageRemark = ''.obs;
  final signatureKey = GlobalKey<SfSignaturePadState>();
  Uint8List? signatureImg;
  Uint8List? damageImg;

  @override
  void onInit() {
    super.onInit();
    requestId.value = params['request_id'];
    getData();
  }

  /// Fetches handover device details from the API and updates the [detail] observable.
  ///
  /// This method sets [isLoading] to `true` while fetching data. It retrieves the
  /// authentication token from [UserPreferences], then makes a GET request to the
  /// handover device detail endpoint with the current [requestId].
  ///
  /// If the response is successful (`statusCode == 200`), it updates [detail] with
  /// the received data. Otherwise, it clears [detail].
  ///
  /// Any errors during the fetch are caught, [detail] is cleared, and the error is logged.
  /// Finally, [isLoading] is set to `false` regardless of success or failure.
  Future<void> getData() async {
    isLoading.value = true;
    try {
      String token = await UserPreferences().getToken();

      final response = await http.get(
        Uri.parse(
          ApiConfig.get_handover_device_detail,
        ).replace(queryParameters: {'request_id': requestId.value}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        detail.clear();
        detail.value = responseData['data'];
      } else {
        detail.clear();
      }
    } catch (e) {
      detail.clear();
      log('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Captures an image using the device camera and updates the state.
  ///
  /// Uses the [ImagePicker] to open the camera and allows the user to take a photo.
  /// If an image is captured, toggles the [isCaptured] value and stores the image bytes in [damageImg].
  /// This method is asynchronous and should be awaited.
  Future<void> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      isCaptured.value = !isCaptured.value;
      damageImg = await image.readAsBytes();
    }
  }

  /// Sends a multipart POST request to confirm pilot handover.
  ///
  /// This method collects necessary handover details, including device information,
  /// category, remarks, and images (damage and signature), and sends them to the
  /// backend API. It retrieves the authorization token from user preferences and
  /// attaches it to the request headers. If a damage image is captured, it is
  /// included in the request. The signature image is always included.
  ///
  /// Returns `true` if the handover is accepted successfully (HTTP 200),
  /// otherwise logs the error and returns `false`.
  ///
  /// Throws an exception if any error occurs during the request process.
  Future<bool> acceptHandover() async {
    try {
      String token = await UserPreferences().getToken();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.confirm_pilot_handover),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['request_id'] = detail['_id']['\$oid'];
      request.fields['handover_to'] = detail['handover_to'];
      request.fields['handover_date'] = DateTime.now().toString();
      request.fields['handover_device_category'] = category.value;
      request.fields['handover_device_remark'] = categoryRemark.value;
      request.fields['deviceno'] = detail['deviceno'];

      if (isCaptured.value) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'damage_img',
            damageImg!,
            filename: 'damage_${detail['_id']['\$oid']}.png',
            contentType: MediaType('image', 'png'),
          ),
        );
      }

      request.files.add(
        http.MultipartFile.fromBytes(
          'signature',
          signatureImg!,
          filename: 'signature_${detail['handover_to']}.png',
          contentType: MediaType('image', 'png'),
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        return true;
      }
      log('Failed to accept handover: ${response.statusCode}');
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      log('Response: $responseString');
      return false;
    } catch (e) {
      log('Error accepting handover: $e');
      return false;
    }
  }
}
