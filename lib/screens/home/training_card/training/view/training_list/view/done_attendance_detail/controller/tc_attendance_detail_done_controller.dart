import 'dart:developer';
import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TC_AttendanceDetail_Done_Controller extends GetxController {
  final attendanceData = Get.arguments; // data dari attendance
  final isLoading = false.obs;

  final attendanceParticipant = [].obs; // data participant yang sudah hadir
  final totalTrainee = 0.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    await totalParticipant();
    totalTrainee.value = await totalAbsent();
    isLoading.value = false;
  }

  Future<int> totalParticipant() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_total_participant_done,
        ).replace(queryParameters: {'_id': attendanceData['_id']}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        attendanceParticipant.assignAll(data['data']);
        return attendanceParticipant.length;
      } else {
        log('Failed to load participants: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      log('Error fetching participants: $e');
      return 0;
    }
  }

  Future<int> totalAbsent() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_total_absent_trainee,
        ).replace(queryParameters: {'idattendance': attendanceData['_id']}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response body : ${response.body}');

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log('good : ${data['data']}');
        return data['data'];
      } else {
        log('Failed to load absent participants: ${response.body}');
        return 0;
      }
    } catch (e) {
      log('Error fetching absent participants: $e');
      return 0;
    }
  }
}
