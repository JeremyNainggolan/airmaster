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

  Future<void> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      isCaptured.value = !isCaptured.value;
      returnedDeviceImg = await image.readAsBytes();
    }
  }

  Future<bool> returnOCC() async {
    String token = await UserPreferences().getToken();
    String userId = await UserPreferences().getIdNumber();

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.confirm_return),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['request_id'] = device['id']['\$oid'];
      request.fields['received_at'] = DateTime.now().toString();
      request.fields['received_by'] = userId;
      request.fields['category'] = category.value;
      request.fields['remark'] = remark.value;
      request.fields['deviceno'] = device['deviceno'];

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
