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

  final checkRequest = false.obs;

  final availableDevicesCount = 0.obs;
  final usedDevicesCount = 0.obs;

  final waitingConfirmation = <Map<String, dynamic>>[].obs;
  final inUse = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    occTabController = TabController(length: 3, vsync: this);
    pilotTabController = TabController(length: 2, vsync: this);
    loadUserData();
    getAvailableDevices();
    getWaitingConfirmation();
    checkingRequest();

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

  Future<void> checkingRequest() async {
    String token = await _userPrefs.getToken();
    String hub = await _userPrefs.getHub();
    String userId = await _userPrefs.getIdNumber();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.check_request,
        ).replace(queryParameters: {'hub': hub, 'request_user': userId}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        checkRequest.value = true;
      } else {
        checkRequest.value = false;
      }
    } catch (e) {
      checkRequest.value = false;
    }
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
      }
    } catch (e) {
      log('Error fetching devices: $e');
    }
  }

  Future<void> getWaitingConfirmation() async {
    String token = await _userPrefs.getToken();
    String hub = await _userPrefs.getHub();
    String userId = await _userPrefs.getIdNumber();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_confirmation_status).replace(
          queryParameters: {
            'hub': hub,
            'request_user': userId,
            'status': 'waiting',
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        waitingConfirmation.clear();
        if (responseData['data'] != null) {
          waitingConfirmation.addAll(
            (responseData['data'] as List)
                .map((item) => item as Map<String, dynamic>)
                .toList(),
          );
        } else {
          waitingConfirmation.clear();
        }
      } else {
        waitingConfirmation.clear();
      }
    } catch (e) {
      log('Error fetching waiting confirmation: $e');
    }
  }

  Future<void> getInUse() async {
    String token = await _userPrefs.getToken();
    String hub = await _userPrefs.getHub();
    String userId = await _userPrefs.getIdNumber();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_confirmation_status).replace(
          queryParameters: {
            'hub': hub,
            'request_user': userId,
            'status': 'in_use',
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        inUse.clear();
        if (responseData['data'] != null) {
          inUse.addAll(
            (responseData['data'] as List)
                .map((item) => item as Map<String, dynamic>)
                .toList(),
          );
        } else {
          inUse.clear();
        }
      } else {
        inUse.clear();
        log('Failed to fetch confirmation status: ${response.statusCode}');
      }
    } catch (e) {
      inUse.clear();
      log('Error fetching waiting confirmation: $e');
    }
  }

  Future<Map<String, dynamic>> getPilotDevices(String searchDevice) async {
    String token = await _userPrefs.getToken();
    String hub = await _userPrefs.getHub();
    String userId = await _userPrefs.getIdNumber();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_pilot_devices).replace(
          queryParameters: {
            'deviceno': searchDevice,
            'hub': hub,
            'request_user': userId,
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> deviceData = responseData['data'];
        if (deviceData.isNotEmpty) {
          return deviceData;
        } else {
          return {};
        }
      } else {
        log("API Error: ${response.body}");
        return {};
      }
    } catch (e) {
      log("Exception in getPilotDevices: $e");
      return {};
    }
  }

  Future<bool> cancelRequest(String requestId, String deviceNo) async {
    String token = await _userPrefs.getToken();

    try {
      final response = await http.delete(
        Uri.parse(ApiConfig.cancel_request).replace(
          queryParameters: {'request_id': requestId, 'deviceno': deviceNo},
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        log("API Error: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Exception in cancelRequest: $e");
      return false;
    }
  }

  Future<void> refreshData() async {
    await loadUserData();
    await getAvailableDevices();
    await getWaitingConfirmation();
    await getInUse();
    await checkingRequest();
  }
}
