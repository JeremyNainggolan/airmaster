import 'dart:developer';
import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TC_TrainingListDetail_Controller extends GetxController
    with GetTickerProviderStateMixin {
  late TabController trainingList;

  @override
  void onInit() {
    super.onInit();
    trainingList = TabController(length: 3, vsync: this);
  }

  Future<List<dynamic>> getAttendanceList(String subject,String status) async {
    String token = await UserPreferences().getToken();
    try {

      final uri = Uri.parse(ApiConfig.get_attendance_list).replace(
        queryParameters:{
          'subject': subject,
          'status': status,
        },
      );
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
        return data['data'];
      } else {
        log('Failed to fetch training cards: ${data['message']}');
        return [];
      }
    } catch (e) {
      log('Error fetching training cards: $e');
      return [];
    }
  }

  Future<bool> deleteTraining(String subject)async{
    String token = await UserPreferences().getToken();

    final uri = Uri.parse(ApiConfig.delete_training_card).replace(
      queryParameters: {
        'subject': subject,
      },
    );

    try {
      final response = await http.delete(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        log('Training card deleted successfully');
        return true;
      } else {
        log('Failed to delete training card: ${jsonDecode(response.body)['message']}');
        return false;
      }
    } catch (e) {
      log('Error deleting training card: $e');
      return false;
    }
  }

}
