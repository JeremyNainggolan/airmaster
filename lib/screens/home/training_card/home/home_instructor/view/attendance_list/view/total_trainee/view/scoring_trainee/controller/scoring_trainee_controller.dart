import 'dart:developer';
import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Ins_ScoringTrainee_Controller extends GetxController {
  final traineeId = Get.arguments['idTrainee'];
  final idAttendanceDetail = Get.arguments['idattendance-detail'];
  final subject = Get.arguments['subject'];
  final traineeDetails = {}.obs;
  final isLoading = false.obs;
  final gradeController = TextEditingController();
  RxDouble communicationScore = 0.0.obs;
  RxDouble knowledgeScore = 0.0.obs;
  RxDouble activeParticipationScore = 0.0.obs;
  final additionalInfoController = TextEditingController();
  final idAttendance = ''.obs;
  final scoreValue = ''.obs;
  final isAgreed = false.obs;
  final agreeError = ''.obs;
  final additionalInfoError = ''.obs;
  final gradeError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTraineeDetails();
  }

  Future<void> fetchTraineeDetails() async {
    isLoading.value = true;

    String token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse(ApiConfig.trainee_details).replace(
        queryParameters: {'idtraining': traineeId, '_id': idAttendanceDetail},
      ),
      headers: {'Authorization': 'Bearer $token', 'accept': 'application/json'},
    );

    Map<String, dynamic> dataTrainee = jsonDecode(response.body);

    try {
      if (response.statusCode == 200) {
        traineeDetails.assignAll(dataTrainee['data']);
        idAttendance.value = traineeDetails['idattendance'] ?? '';
        log('Trainee Details: $traineeDetails');
        scoreValue.value = traineeDetails['score'] ?? 'PASS';
        gradeController.text = traineeDetails['grade']?.toString() ?? '';
        communicationScore.value =
            traineeDetails['rCommunication']?.toDouble() ?? 0.0;
        knowledgeScore.value = traineeDetails['rKnowledge']?.toDouble() ?? 0.0;
        activeParticipationScore.value =
            traineeDetails['rActive']?.toDouble() ?? 0.0;
        additionalInfoController.text = traineeDetails['feedback'] ?? '';

        log('Communication Score: ${communicationScore.value}');

        log('Score Value: ${scoreValue.value}');
        isLoading.value = false;
      } else {
        log('Failed to load trainee details: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching trainee details: $e');
    }
  }

  Future<bool> submitScore() async {
    String token = await UserPreferences().getToken();

    final int grade = int.tryParse(gradeController.text) ?? 0;
    final int rActive = activeParticipationScore.value.round();
    final int rKnowledge = knowledgeScore.value.round();
    final int rCommunication = communicationScore.value.round();

    final totalPassTrainee = await checkTraineeScore() + 1;
    log('Total Pass Trainee: $totalPassTrainee');
    final formatNo = '$subject-${totalPassTrainee.toString().padLeft(3, '0')}';
    log('Format No: $formatNo');

    final response = await http.post(
      Uri.parse(
        ApiConfig.save_trainee_score,
      ).replace(queryParameters: {'_id': idAttendanceDetail}),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'subject': subject,
        'status': 'donescoring',
        'rActive': rActive,
        'rKnowledge': rKnowledge,
        'rCommunication': rCommunication,
        'feedback': additionalInfoController.text,
        'grade': grade,
        'score': scoreValue.value,
        'formatNo': formatNo,
      }),
    );

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Score submitted successfully: ${data['message']}');
        return true;
      } else {
        log(
          'Failed to submit score: '
          '${jsonDecode(response.body)['message']}',
        );
        return false;
      }
    } catch (e) {
      log('Error submitting score: $e');
      return false;
    }
  }

  Future<int> checkTraineeScore() async {
    String token = await UserPreferences().getToken();

    log('ID Attendance: ${idAttendance.value}');

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.check_trainee_score,
        ).replace(queryParameters: {'idattendance': idAttendance.value}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Check Trainee Score Response: ${data['score']}');
        return data['score'];
      } else {
        log('Failed to check trainee score: ${response.statusCode}');
      }
      return 0;
    } catch (e) {
      log('Error checking trainee score: $e');
      return 0;
    }
  }
}
