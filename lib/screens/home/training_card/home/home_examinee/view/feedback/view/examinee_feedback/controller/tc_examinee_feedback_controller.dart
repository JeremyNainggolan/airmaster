import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: TC Examinee Feedback Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Examinee Feedback feature.
  | It manages the state and logic for the examinee feedback operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_ExamineeFeedback_Controller extends GetxController {
  RxDouble teachingMethodScore = 0.0.obs;
  RxDouble masteryScore = 0.0.obs;
  RxDouble timeManagementScore = 0.0.obs;

  final additionalInfoController = TextEditingController();
  final additionalInfoError = ''.obs;

  /// Submits feedback for an examinee's training session.
  ///
  /// This method collects the mastery, time management, and teaching method scores,
  /// along with additional feedback for the instructor, and sends them to the server
  /// using an HTTP POST request. The request includes authentication via a bearer token.
  ///
  /// Returns `true` if the feedback was submitted successfully (HTTP 200),
  /// otherwise returns `false`. Any exceptions during the process also result in `false`.
  ///
  /// The following parameters are sent in the request body:
  /// - `rMastery`: Rounded mastery score.
  /// - `rTimeManagement`: Rounded time management score.
  /// - `rTeachingMethod`: Rounded teaching method score.
  /// - `feedbackForInstructor`: Additional feedback text for the instructor.
  ///
  /// The request URL includes the following query parameters:
  /// - `idtraining`: Training session ID (from navigation arguments).
  /// - `_id`: Examinee ID (from navigation arguments).
  ///
  /// Requires:
  /// - Valid authentication token from `UserPreferences`.
  /// - Scores and feedback to be set prior to calling this method.
  Future<bool> submitFeedback() async {
    String token = await UserPreferences().getToken();

    final int rMastery = masteryScore.value.round();
    final int rTimeManagement = timeManagementScore.value.round();
    final int rTeachingMethod = teachingMethodScore.value.round();

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.examinee_feedback).replace(
          queryParameters: {
            'idtraining': Get.arguments['idtraining'],
            '_id': Get.arguments['_id'],
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'rMastery': rMastery,
          'rTimeManagement': rTimeManagement,
          'rTeachingMethod': rTeachingMethod,
          'feedbackForInstructor': additionalInfoController.text,
        }),
      );

      if (response.statusCode == 200) {
        log('Feedback submitted successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
