// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:airmaster/config/api_config.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Training Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the TC Training feature.
  | It manages the state and logic for the training operations.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Training_Controller extends GetxController {
  final List<dynamic> trainingList = [].obs;
  final isLoading = false.obs;

  List<Map<String, dynamic>> trainingRemarks = [];

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    getTrainingCard();
    await getTrainingRemarks();
    log('Training Remarks: $trainingRemarks');
    isLoading.value = false;
  }

  /// Fetches training remarks from the API and updates the [trainingRemarks] list.
  ///
  /// This method retrieves the authentication token, sends a GET request to the
  /// training remarks endpoint, and parses the response. The remarks are converted
  /// into a list of maps with 'code' and 'desc' keys, then stored in [trainingRemarks].
  /// Logs success or failure messages for debugging purposes.
  ///
  /// Handles errors gracefully and logs any exceptions encountered during the process.
  Future<void> getTrainingRemarks() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_training_remarks),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> rawList = decoded['data'] ?? [];

        // Konversi ke format {'code': ..., 'desc': ...}
        final convertedList =
            rawList.map<Map<String, String>>((item) {
              return {
                'code': item['training_code']?.toString() ?? '',
                'desc': item['remark']?.toString() ?? '',
              };
            }).toList();

        trainingRemarks.clear(); // opsional: kalau kamu mau reset dulu
        trainingRemarks.addAll(convertedList);

        log('Training remarks fetched successfully: $trainingRemarks');
      } else {
        log('Failed to fetch training remarks: ${response.reasonPhrase}');
      }
    } catch (e) {
      log('Error fetching training remarks: $e');
    }
  }

  /// Fetches the training card data from the API.
  ///
  /// Retrieves the authentication token from user preferences and sends a GET request
  /// to the training cards endpoint. If the request is successful (HTTP 200), it clears
  /// the existing training list and populates it with the fetched data. Returns the list
  /// of training cards on success. Logs relevant information and errors during the process.
  ///
  /// Returns:
  ///   A `Future` that resolves to the list of training cards if successful, otherwise `null`.
  ///
  /// Throws:
  ///   Logs any exceptions encountered during the fetch operation.
  Future getTrainingCard() async {
    String token = await UserPreferences().getToken();
    log('Token: $token');
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_training_cards),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log(jsonDecode(response.body).toString());

      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // log('Data: ${data['data']}');
        log('Training cards fetched successfully');
        trainingList.clear();
        trainingList.addAll(data['data']);

        return data['data'];
      } else {
        log('Failed to fetch training cards: ${data['message']}');
      }
    } catch (e) {
      log('Error fetching training cards: $e');
    }
  }
}
