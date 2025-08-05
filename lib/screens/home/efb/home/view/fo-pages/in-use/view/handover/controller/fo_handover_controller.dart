import 'dart:convert' show jsonDecode;
import 'dart:developer';
import 'dart:typed_data';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

/*
  |--------------------------------------------------------------------------
  | File: FO Handover Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling FO Handover operations.
  | It manages the state and logic for FO Handover requests, including
  | fetching details, accepting handover, and capturing signatures.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-04
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Handover_Controller extends GetxController {
  dynamic params = Get.arguments;

  final requestId = ''.obs;
  final isLoading = false.obs;

  final detail = {}.obs;

  final isCaptured = false.obs;
  final mainDeviceCategory = 'Good'.obs;
  final mainDeviceCategoryRemark = ''.obs;
  final backupDeviceCategory = 'Good'.obs;
  final backupDeviceCategoryRemark = ''.obs;
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
  /// - Sets [isLoading] to `true` while fetching data.
  /// - Retrieves the authentication token from [UserPreferences].
  /// - Sends a GET request to the handover device detail endpoint with the current [requestId].
  /// - On success (`statusCode == 200`), updates [detail] with the received data.
  /// - On failure or exception, clears [detail].
  /// - Sets [isLoading] to `false` after the operation completes.
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
    } finally {
      isLoading.value = false;
    }
  }

  /// Captures an image using the device camera and updates the state.
  ///
  /// Uses the [ImagePicker] to open the camera and allows the user to take a photo.
  /// If an image is captured, toggles the [isCaptured] value and stores the image bytes in [damageImg].
  /// Does nothing if the user cancels the image capture.
  Future<void> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      isCaptured.value = !isCaptured.value;
      damageImg = await image.readAsBytes();
    }
  }

  /// Sends a request to accept a handover by submitting relevant data and files to the server.
  ///
  /// This method performs the following steps:
  /// - Retrieves the authentication token from user preferences.
  /// - Constructs a multipart POST request to the handover confirmation API endpoint.
  /// - Adds required fields such as request ID, handover details, device categories, remarks, and device numbers.
  /// - Optionally attaches a damage image if it has been captured.
  /// - Attaches a signature image.
  /// - Sends the request and logs the response body.
  /// - Returns `true` if the server responds with a 200 status code, otherwise returns `false`.
  /// - Returns `false` if any exception occurs during the process.
  ///
  /// Returns a [Future] that completes with a boolean indicating the success of the handover acceptance.
  Future<bool> acceptHandover() async {
    try {
      String token = await UserPreferences().getToken();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.confirm_pilot_handover),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['isFoRequest'] = 'true';
      request.fields['request_id'] = detail['_id']['\$oid'];
      request.fields['handover_to'] = detail['handover_to'];
      request.fields['handover_date'] = DateTime.now().toString();
      request.fields['main_device_category'] = mainDeviceCategory.value;
      request.fields['main_device_remark'] = mainDeviceCategoryRemark.value;
      request.fields['backup_device_category'] = backupDeviceCategory.value;
      request.fields['backup_device_remark'] = backupDeviceCategoryRemark.value;
      request.fields['mainDeviceNo'] = detail['mainDeviceNo'];
      request.fields['backupDeviceNo'] = detail['backupDeviceNo'];

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
      final responseBody = await response.stream.bytesToString();
      log('Response body: $responseBody');

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
