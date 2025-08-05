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

/*
  |--------------------------------------------------------------------------
  | File: TC Instructor Attendance List Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Instructor Attendance List feature.
  | It manages the state and logic for attendance operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
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
    log('Attendance Data: $attendanceData');
  }

  Future<void> refreshData() async {
    await getAttendance(await attendanceData['_id']);
  }

  /// Confirms attendance by sending a multipart POST request to the server.
  ///
  /// This method performs the following steps:
  /// - Retrieves the user's authentication token.
  /// - Constructs a multipart request to the attendance confirmation API endpoint,
  ///   including the attendance ID as a query parameter.
  /// - Sets the required headers for authorization and content type.
  /// - Adds attendance type and remarks as form fields.
  /// - Attaches the signature image as a multipart file.
  /// - Sends the request and logs the response body.
  /// - Returns `true` if the attendance confirmation is successful (HTTP 200),
  ///   otherwise logs the error and returns `false`.
  ///
  /// Returns a [Future] that completes with `true` if the attendance is confirmed successfully,
  /// or `false` if an error occurs or the response status is not 200.
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

  /// Fetches attendance data for a given attendance ID from the server.
  ///
  /// This method sends an HTTP GET request to the attendance API endpoint,
  /// including the provided [idattendance] as a query parameter and an
  /// authorization token in the headers. Upon a successful response (HTTP 200),
  /// it updates the [attendanceParticipant] list and [totalTrainee] value with
  /// the received data, and sets [isLoading] to false. If the request fails or
  /// an exception occurs, it logs the error and returns `false`.
  ///
  /// Returns `true` if the attendance data was successfully fetched and updated,
  /// otherwise returns `false`.
  ///
  /// [idattendance] - The ID of the attendance record to fetch.
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
