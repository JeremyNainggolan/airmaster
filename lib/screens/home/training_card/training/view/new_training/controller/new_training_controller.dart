import 'dart:convert';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:airmaster/config/api_config.dart';

class TC_NewTrainingController extends GetxController {
  // Define your variables and methods
  final formKey = GlobalKey<FormState>();

  TextEditingController subjectController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // ignore: non_constant_identifier_names
  bool is_delete = false;

  Future saveTraining() async {

    String token = await UserPreferences().getToken();
    try {
      final response = await http.post(Uri.parse(ApiConfig.new_training_card), body: {
      'subject': subjectController.text,
      'date': dateController.text,
      'description': descriptionController.text,
      'is_delete': is_delete,
      },
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
        
      return jsonDecode(response.body);
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to save training: $e');
    }
    
  }
}
