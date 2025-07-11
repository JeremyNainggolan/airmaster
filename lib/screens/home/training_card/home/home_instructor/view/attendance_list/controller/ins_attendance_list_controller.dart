// ignore_for_file: camel_case_types
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class TC_Ins_AttendanceList_Controller extends GetxController {
  final isLoading = false.obs;
  final selectedOption = 'Meeting'.obs;
  final attendanceData = Get.arguments;
  final remarksController = TextEditingController();
  final remarksError = ''.obs;

  final attendanceParticipant = [].obs;

  final totalTrainee = ''.obs;

  final signatureKey = GlobalKey<SfSignaturePadState>();
  Uint8List? signatureImg;

  @override
  void onInit() async {
    super.onInit();
    await getAttendance(await attendanceData['_id']);
  }

  Future<void> refreshData() async {
    await getAttendance(await attendanceData['_id']);
  }

  Future<bool> confirmAttendance() async {
    String token = await UserPreferences().getToken();

    try {
      final request = http.MultipartRequest(
        'post',
        Uri.parse(
          ApiConfig.confirm_attendance,
        ).replace(queryParameters: {'_id': '${attendanceData['_id']}'}),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['attendanceType'] = selectedOption.value;
      request.fields['remarks'] = remarksController.text;

      request.files.add(
        http.MultipartFile.fromBytes(
          'signature',
          signatureImg!,
          filename: 'signature_${attendanceData['_id']}.png',
          contentType: MediaType('image', 'png'),
        ),
      );

      final response = await request.send();

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

  Future<bool> getAttendance(String idattendance) async {
    String token = await UserPreferences().getToken();
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_attendance,
        ).replace(queryParameters: {'idattendance': idattendance}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        attendanceParticipant.assignAll(data['data']['attendance']);
        log('Attendance Participant: $attendanceParticipant');
        totalTrainee.value = '${data['data']['totalAttendance']}';
        isLoading.value = false;
        return true;
      } else {
        log('Response body: ${data['message']}');
        return false;
      }
    } catch (e) {
      log('Error: $e');
      return false;
    }
  }
}
