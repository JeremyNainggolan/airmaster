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

class Accept_Handover_Controller extends GetxController {
  dynamic params = Get.arguments;

  final requestId = ''.obs;
  final isLoading = false.obs;

  final detail = {}.obs;

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

  Future<void> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      isCaptured.value = !isCaptured.value;
      damageImg = await image.readAsBytes();
    }
  }

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
