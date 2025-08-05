import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: TC Absent Participant Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for managing absent participants in a training session.
  | It handles fetching and filtering absent participant data.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_AbsentParticipant_Controller extends GetxController {
  final participantId = Get.arguments; // data idattendace
  final dataAbsent = [].obs; // data participant yang tidak hadir
  final searchNameController = TextEditingController();
  final isLoading = false.obs;

  RxList<dynamic> trainee = [].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    await getAbsentParticipant();
    trainee.assignAll(dataAbsent);
    isLoading.value = false;
  }

  /// Fetches the list of absent participants for a specific attendance ID.
  ///
  /// This method retrieves the authentication token, sends an HTTP GET request
  /// to the absent participant API endpoint with the given attendance ID, and
  /// updates the `dataAbsent` list with the received data if the request is successful.
  ///
  /// Logs the response body for debugging purposes. If the request fails or an
  /// exception occurs, logs the error message.
  ///
  /// Throws no exceptions; errors are logged internally.
  Future<void> getAbsentParticipant() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_absent_participant,
        ).replace(queryParameters: {'idattendance': participantId}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      log('Response body : ${response.body}');

      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        dataAbsent.assignAll(data['data']);
      } else {
        log('Failed to load absent participants: ${response.body}');
      }
    } catch (e) {
      log('Error fetching absent participants: $e');
    }
  }

  /// Filters the list of absent trainees based on the provided [query].
  ///
  /// If [query] is empty, all absent trainees are shown. Otherwise, only trainees
  /// whose names contain the [query] (case-insensitive) are included in the list.
  ///
  /// Updates the [trainee] list with the filtered results.
  void showFilteredTrainees(String query) {
    if (query.isEmpty) {
      trainee.assignAll(dataAbsent);
    } else {
      final lower = query.toLowerCase();
      trainee.assignAll(
        dataAbsent.where(
          (e) => (e['trainee_name'] ?? '').toLowerCase().contains(lower),
        ),
      );
    }
  }
}
