import 'dart:developer';
import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: Scoring Trainee Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the Scoring Trainee feature.
  | It manages the state and logic for scoring trainee operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
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

  /// Fetches the details of a trainee from the server.
  ///
  /// This method sets the [isLoading] flag to `true` while fetching data.
  /// It retrieves the authentication token, sends an HTTP GET request to the
  /// trainee details API endpoint with the required query parameters, and
  /// parses the response.
  ///
  /// On a successful response (`statusCode == 200`), it:
  /// - Assigns the trainee details to [traineeDetails].
  /// - Updates [idAttendance], [scoreValue], [gradeController], [communicationScore],
  ///   [knowledgeScore], [activeParticipationScore], and [additionalInfoController]
  ///   with the corresponding values from the response.
  /// - Logs relevant information for debugging.
  /// - Sets [isLoading] to `false`.
  ///
  /// If the response fails or an exception occurs, it logs the error.
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

  /// Submits the trainee's score to the server.
  ///
  /// This method collects the necessary scoring data from the controllers,
  /// formats the trainee number, and sends a POST request to the API endpoint
  /// to save the trainee's score. The request includes authorization and
  /// relevant scoring details in the body.
  ///
  /// Returns `true` if the score was submitted successfully, otherwise `false`.
  ///
  /// Logs the process and any errors encountered during submission.
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

  /// Checks the score of a trainee for a specific attendance ID.
  ///
  /// This asynchronous method retrieves the authentication token, logs the attendance ID,
  /// and sends a GET request to the API to fetch the trainee's score. If the request is
  /// successful (HTTP 200), it returns the score from the response. If the request fails
  /// or an error occurs, it logs the error and returns 0.
  ///
  /// Returns the trainee's score as an [int], or 0 if the score cannot be retrieved.
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
