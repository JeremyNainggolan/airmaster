import 'dart:developer';
import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: TC Training List Detail Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for managing training list details.
  | It handles fetching attendance lists and deleting training cards.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_TrainingListDetail_Controller extends GetxController
    with GetTickerProviderStateMixin {
  late TabController trainingList;

  final attendanceListPending = [].obs;
  final attendanceListConfirmed = [].obs;
  final attendanceListDone = [].obs;

  final subject = Get.arguments;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    trainingList = TabController(length: 3, vsync: this);
    getAttendanceList(subject);
  }

  /// Fetches the attendance list for a given subject from the API.
  ///
  /// This method sets the [isLoading] flag to `true` while fetching data.
  /// It retrieves the authentication token, constructs the API request URI
  /// with the provided [subject] as a query parameter, and sends a GET request.
  ///
  /// On a successful response (`statusCode == 200`), it updates the attendance lists:
  /// - [attendanceListPending] with pending attendance data
  /// - [attendanceListConfirmed] with confirmed attendance data
  /// - [attendanceListDone] with done attendance data
  ///
  /// Logs relevant information for debugging purposes.
  /// If the request fails or an exception occurs, logs the error message.
  ///
  /// [subject]: The subject identifier for which to fetch the attendance list.
  Future<void> getAttendanceList(String subject) async {
    isLoading.value = true;

    String token = await UserPreferences().getToken();
    try {
      final uri = Uri.parse(
        ApiConfig.get_attendance_list,
      ).replace(queryParameters: {'subject': subject});
      final response = await http.get(
        uri,
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
        attendanceListPending.value = data['data']['pending'];
        attendanceListConfirmed.value = data['data']['confirmed'];
        attendanceListDone.value = data['data']['done'];

        isLoading.value = false;
        log('Pending: $attendanceListPending');
      } else {
        log('Failed to fetch training cards: ${data['message']}');
      }
    } catch (e) {
      log('Error fetching training cards: $e');
    }
  }

  /// Deletes a training card identified by the given [subject].
  ///
  /// Retrieves the authentication token from [UserPreferences], constructs the
  /// appropriate URI with the [subject] as a query parameter, and sends an HTTP
  /// DELETE request to the API endpoint specified in [ApiConfig.delete_training_card].
  ///
  /// Returns `true` if the training card was deleted successfully (HTTP 200),
  /// otherwise returns `false`. Logs the result of the operation for debugging purposes.
  ///
  /// In case of an error during the request, logs the error and returns `false`.
  ///
  /// [subject] - The identifier of the training card to delete.
  Future<bool> deleteTraining(String subject) async {
    String token = await UserPreferences().getToken();

    final uri = Uri.parse(
      ApiConfig.delete_training_card,
    ).replace(queryParameters: {'training': subject});

    try {
      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        log('Training card deleted successfully');
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        log(
          'Failed to delete training card: ${jsonDecode(response.body)['message']}',
        );
        return false;
      }
    } catch (e) {
      log('Error deleting training card: $e');
      return false;
    }
  }
}
