// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TC_TrainingList_Controller extends GetxController {
  final List<dynamic> trainingList = [].obs;
  final isLoading = false.obs;

  final passwordController = TextEditingController();

  final attendanceDetail = {}.obs;

  List<Map<String, String>> trainingRemarks = [
    {'code': 'RVSM', 'desc': 'Reduced Vertical Separation Minima'},
    {'code': 'SEP', 'desc': 'Safety Emergency Procedures'},
    {'code': 'DGR', 'desc': 'Dangerous Goods and Regulations'},
    {'code': 'AVSEC', 'desc': 'Aviation Security'},
    {'code': 'SMS', 'desc': 'Safety Management System'},
    {'code': 'CRM', 'desc': 'Crew Resource Management'},
    {
      'code': 'ALAR/CFIT',
      'desc':
          'Approach and Landing Accident Reduction/Controlled Flight Into Terrain',
    },
    {'code': 'PBN', 'desc': 'Performance Based Navigation'},
    {'code': 'RGT', 'desc': 'Recurrent Ground Training'},
    {'code': 'RNAV (GNSS)', 'desc': 'Required Navigation (GNSS)'},
    {'code': 'LVO', 'desc': 'Low Visibility Operation'},
    {'code': 'RHS CHECK', 'desc': 'Right Hand Seat Check'},
    {'code': 'UPRT', 'desc': 'Upset and Recovery Training'},
  ];

  @override
  void onInit() {
    super.onInit();
    getTrainingCard();
  }

  Future<void> refreshTrainingCard() async {
    isLoading.value = true;
    passwordController.clear();
    await getTrainingCard();
    isLoading.value = false;
  }

  Future getTrainingCard() async {
    isLoading.value = true;

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

        isLoading.value = false;
        return data['data'];
      } else {
        log('Failed to fetch training cards: ${data['message']}');
      }
    } catch (e) {
      log('Error fetching training cards: $e');
    }
  }

  Future<int> getClassOpen(String subject) async {
    String token = await UserPreferences().getToken();
    String userId = await UserPreferences().getIdNumber();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_class_open,
        ).replace(queryParameters: {'subject': subject, 'userId': userId}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        attendanceDetail.clear();
        attendanceDetail.value = jsonDecode(response.body)['data'];
        return 1; // Success
      } else if (response.statusCode == 204) {
        return 2; // Gadak kelas
      } else if (response.statusCode == 404) {
        return 3; // Not Found
      } else {
        return 0; // Error
      }
    } catch (e) {
      log('Error fetching class open: $e');
      return 0; // Error
    }
  }



  Future<int> checkClassPassword(String subject, String password) async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.check_class_password,
        ).replace(queryParameters: {'subject': subject, 'password': password}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('messagenyaa: ${jsonDecode(response.body).toString()}');

      if (response.statusCode == 200) {
        attendanceDetail.clear();
        attendanceDetail.value = jsonDecode(response.body)['data'];
        log('Detail: ${attendanceDetail.toString()}');
        return 1; // Password is correct
      } else if (response.statusCode == 404) {
        return 2; // Not Found, wrong password
      } else {
        return 0; // Other error
      }
    } catch (e) {
      log('Error checking class password: $e');
      return 0; // Error
    }
  }
}
