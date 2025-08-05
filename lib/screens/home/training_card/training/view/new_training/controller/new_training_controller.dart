// ignore: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:airmaster/config/api_config.dart';

/*
  |--------------------------------------------------------------------------
  | File: New Training Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the New Training feature.
  | It manages the state and logic for creating new training records.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_NewTrainingController extends GetxController {
  late GlobalKey<FormState> formKey;

  final trainingController = TextEditingController();
  final descriptionController = TextEditingController();

  RxString selectedTrainingType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
  }

  /// Saves a new training entry to the server.
  ///
  /// Sends a POST request to the API endpoint specified in [ApiConfig.new_training_card]
  /// with the training details provided by [trainingController], [selectedTrainingType],
  /// and [descriptionController]. The request includes an authorization token retrieved
  /// from [UserPreferences].
  ///
  /// Returns `true` if the training is saved successfully (HTTP 200), `false` otherwise.
  /// In case of an exception, logs the error and returns `false`.
  ///
  /// Logs the server response for debugging purposes.
  Future<bool?> saveTraining() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.new_training_card),
        body: {
          'training': trainingController.text,
          'recurrent': selectedTrainingType.value,
          'training_description': descriptionController.text,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log(jsonDecode(response.body).toString());

      if (response.statusCode == 200) {
        log('Training saved successfully');
        return true;
      } else {
        log('Failed to save training: ${jsonDecode(response.body)['message']}');
        return false;
      }
    } catch (e) {
      log('Error saving training: $e');
      return false;
    }
  }
}
