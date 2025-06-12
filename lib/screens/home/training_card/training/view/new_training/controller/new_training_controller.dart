import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:airmaster/config/api_config.dart';

class TC_NewTrainingController extends GetxController {
  // Define your variables and methods

  late GlobalKey<FormState> formKey;

  final trainingController = TextEditingController();
  final descriptionController = TextEditingController();
  // ignore: non_constant_identifier_names

  RxString selectedTrainingType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
  }

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
