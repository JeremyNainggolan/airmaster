import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: TC Training History Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Training History feature.
  | It manages the state and logic for the training history operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_TrainingHistory_Controller extends GetxController {
  final isLoading = true.obs;
  final historyData = Get.arguments;
  final RxString subject = ''.obs;
  final RxString status = ''.obs;
  final RxString traineeId = ''.obs;
  final trainingHistory = [].obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    subject.value = historyData['attendance']['training'];
    status.value = historyData['status'] ?? '';
    traineeId.value = historyData['idTrainee'] ?? '';
    getTrainingHistory();
    isLoading.value = false;
  }

  /// Fetches the training history for a specific trainee and subject.
  ///
  /// This method retrieves the authentication token, then sends an HTTP GET request
  /// to the participant training history API endpoint with the provided trainee ID and subject.
  /// If the request is successful (status code 200), it parses the response and updates
  /// the `trainingHistory` list with the received data. In case of failure or error,
  /// it logs the issue and returns an empty list.
  ///
  /// Returns a [Future] that resolves to a [List<dynamic>] containing the training history data.
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
