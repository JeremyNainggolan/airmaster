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
  final traineeDetails = {}.obs;
  final isLoading = false.obs;
  final gradeController = TextEditingController();
  RxDouble communicationScore = 0.0.obs;
  RxDouble knowledgeScore = 0.0.obs;
  RxDouble activeParticipationScore = 0.0.obs;
  final additionalInfoController = TextEditingController();
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
      Uri.parse(
        ApiConfig.trainee_details,
      ).replace(queryParameters: {'idtraining': traineeId}),
      headers: {'Authorization': 'Bearer $token', 'accept': 'application/json'},
    );

    Map<String, dynamic> dataTrainee = jsonDecode(response.body);

    try {
      if (response.statusCode == 200) {
        traineeDetails.assignAll(dataTrainee['data']);
        log('Trainee Details: $traineeDetails');
        scoreValue.value = traineeDetails['attendance_score'] ?? 'PASS';
        gradeController.text = traineeDetails['attendance_grade']?.toString() ?? '';
        communicationScore.value = traineeDetails['attendance_rCommunication']?.toDouble() ?? 0.0;
        knowledgeScore.value = traineeDetails['attendance_rKnowledge']?.toDouble() ?? 0.0;
        activeParticipationScore.value = traineeDetails['attendance_rActive']?.toDouble() ?? 0.0;
        additionalInfoController.text = traineeDetails['attendance_feedback'] ?? '';

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
        'status': 'donescoring',
        'rActive': rActive, 
        'rKnowledge': rKnowledge, 
        'rCommunication': rCommunication, 
        'feedback': additionalInfoController.text,
        'grade': grade, 
        'score': scoreValue.value, 
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
}
