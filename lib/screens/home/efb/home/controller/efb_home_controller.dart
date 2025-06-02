// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EFB_Home_Controller extends GetxController
    with GetTickerProviderStateMixin {
  final UserPreferences _userPrefs = UserPreferences();

  late TabController occTabController;
  late TabController pilotTabController;

  final name = ''.obs;
  final imgUrl = ''.obs;
  final hub = ''.obs;
  final rank = ''.obs;

  final greetings = ''.obs;

  final availableDevicesCount = 0.obs;
  final usedDevicesCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    occTabController = TabController(length: 3, vsync: this);
    pilotTabController = TabController(length: 2, vsync: this);
    loadUserData();
    getAvailableDevices();

    var hour = DateTime.now().hour;
    if (hour < 12) {
      greetings.value = "Morning";
    } else if (hour < 17) {
      greetings.value = "Afternoon";
    } else {
      greetings.value = "Evening";
    }
  }

  @override
  void onClose() {
    occTabController.dispose();
    pilotTabController.dispose();
    super.onClose();
  }

  Future<void> loadUserData() async {
    await _userPrefs.init();
    name.value = await _userPrefs.getName();
    imgUrl.value = await _userPrefs.getImgUrl();
    hub.value = await _userPrefs.getHub();
    rank.value = await _userPrefs.getRank();
  }

  Future<void> getAvailableDevices() async {
    String token = await _userPrefs.getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_count_devices,
        ).replace(queryParameters: {'hub': hub.value}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        availableDevicesCount.value = responseData['data']['available'] ?? 0;
        usedDevicesCount.value = responseData['data']['used'] ?? 0;

        log('Available devices: ${availableDevicesCount.value}');
        log('Used devices: ${usedDevicesCount.value}');
      } else {
        log('Failed to fetch devices: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching devices: $e');
    }
  }

  Future<Map<String, dynamic> getWaitingConfirmation() async {
    
  }
}
