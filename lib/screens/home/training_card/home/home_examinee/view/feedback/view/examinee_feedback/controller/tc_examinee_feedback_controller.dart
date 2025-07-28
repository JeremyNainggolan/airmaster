import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/helpers/show_alert.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TC_ExamineeFeedback_Controller extends GetxController {
  RxDouble teachingMethodScore = 0.0.obs;
  RxDouble masteryScore = 0.0.obs;
  RxDouble timeManagementScore = 0.0.obs;

  final additionalInfoController = TextEditingController();
  final additionalInfoError = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

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
