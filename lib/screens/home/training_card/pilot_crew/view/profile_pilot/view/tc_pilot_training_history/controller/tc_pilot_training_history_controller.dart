import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: TC Pilot Training History Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Pilot Training History feature.
  | It manages the state and logic for the pilot training history operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_PilotTrainingHistory_Controller extends GetxController {
  final isLoading = true.obs;
  final historyData = Get.arguments;
  final RxString subject = ''.obs;
  final RxString status = ''.obs;
  final RxString traineeId = ''.obs;
  final trainingHistory = [].obs;
  final pilotType = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    pilotType.value = await UserPreferences().getType();
    isLoading.value = true;
    subject.value = historyData['attendance']['training'];
    status.value = historyData['status'] ?? '';
    traineeId.value = historyData['idTrainee'] ?? '';
    getTrainingHistory();
    isLoading.value = false;
  }

  /// Fetches the training history for a pilot trainee based on the provided
  /// `traineeId` and `subject` values.
  ///
  /// Makes an HTTP GET request to the API endpoint specified in
  /// `ApiConfig.get_participant_training_history`, including the user's
  /// authentication token in the request headers.
  ///
  /// Returns a `List<dynamic>` containing the training history data if the
  /// request is successful (HTTP 200). If the request fails or an error occurs,
  /// returns an empty list.
  ///
  /// Logs relevant information and errors for debugging purposes.
  Future<List<dynamic>> getTrainingHistory() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_participant_training_history).replace(
          queryParameters: {
            'idtraining': traineeId.value,
            'subject': subject.value,
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      // log('Response: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        trainingHistory.assignAll(data['data']);
        log('Training History: $trainingHistory');
        return data['data'] ?? [];
      } else {
        log(
          'Failed to load participant training history: ${response.statusCode}',
        );
        return [];
      }
    } catch (e) {
      log('Error while fetching training list : $e');
      return [];
    }
  }
}
