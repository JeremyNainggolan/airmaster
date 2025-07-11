import 'dart:developer';
import 'dart:typed_data';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:http_parser/http_parser.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:http/http.dart' as http;

class Examinee_CreateAttendance_Controller extends GetxController {
  dynamic data = Get.arguments;
  final attendanceData = {}.obs;

  final signatureKey = GlobalKey<SfSignaturePadState>();
  Uint8List? signatureImg;

  @override
  void onInit() {
    super.onInit();
    attendanceData.value = data['attendanceDetail'];
    createAttendance();
  }

  Future<bool> createAttendance() async {
    String token = await UserPreferences().getToken();

    try {
      final request = http.MultipartRequest(
        'post',
        Uri.parse(ApiConfig.create_attendance_detail),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['idAttendance'] = attendanceData['_id'];
      request.fields['idTraining'] = await UserPreferences().getIdNumber();
      request.fields['idTrainingType'] = attendanceData['idTrainingType'];

      request.files.add(
        http.MultipartFile.fromBytes(
          'signature',
          signatureImg!,
          filename: 'signature_${attendanceData['id']}.png',
          contentType: MediaType('image', 'png'),
        ),
      );
      final response = await request.send();
      log('Failed to create attendance: ${response.statusCode}');
        log('Response body: ${await response.stream.bytesToString()}');
      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        log('Failed to create attendance: ${response.statusCode}');
        log('Response body: ${await response.stream.bytesToString()}');
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }

    } catch (e) {
      log('Error creating attendance: $e');
      await Future.delayed(const Duration(seconds: 2));
      
      return false;
    }
  }
}
