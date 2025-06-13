import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Detail_Feedback_Controller extends GetxController {
  dynamic params = Get.arguments;

  final feedback = {}.obs;

  final reqId = ''.obs;

  Future<void> getFeedbackDetail(String requestId) async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_feedback_detail,
        ).replace(queryParameters: {'request_id': requestId}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        feedback.value = responseData['data'][0];
      }
    } catch (e) {
      log('Error fetching feedback detail: $e');
    }
  }
}
