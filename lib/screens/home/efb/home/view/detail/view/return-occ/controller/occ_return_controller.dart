import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
      request.fields['request_id'] = device['id']['\$oid'];
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
      return true;
    }
  }
}
