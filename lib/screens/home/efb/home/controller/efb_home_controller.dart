// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: EFB Main Controller
  |--------------------------------------------------------------------------
  | 
  | This file defines the EFB_Home_Controller class, which manages the state and 
  | API interactions for the EFB home screen in the AirMaster application. It 
  | handles user data, device status, and request/confirmation flows for both 
  | pilots and OCC users. The controller uses observables for reactive UI updates 
  | and provides methods for loading, refreshing, and updating device and request 
  | information via HTTP requests.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-04-24
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class EFB_Home_Controller extends GetxController
    with GetTickerProviderStateMixin {
  // User preferences instance for accessing user data
  final UserPreferences _userPrefs = UserPreferences();

  // Tab controllers for OCC and Pilot tabs
  late TabController occTabController;
  late TabController pilotTabController;

  // Observable variables for user and device data
  final name = ''.obs;
  final imgUrl = ''.obs;
  final hub = ''.obs;
  final rank = ''.obs;

  // Observable variables for greetings and request status
  final greetings = ''.obs;

  // Observable variable to check if a request is pending
  final checkRequest = false.obs;

  // Observable variables for device counts and statuses
  final availableDevicesCount = 0.obs;
  final usedDevicesCount = 0.obs;

  // Observable variables for request and confirmation data
  final waitingConfirmation = {}.obs;
  final inUse = {}.obs;
  final pilotHandover = {}.obs;

  // Observable variables for OCC request data
  final requestConfirmationOCC = <Map<String, dynamic>>[].obs;
  final deviceUsedOCC = <Map<String, dynamic>>[].obs;
  final returnConfirmationOCC = <Map<String, dynamic>>[].obs;

  // Observable variable to track loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    occTabController = TabController(length: 3, vsync: this);
    pilotTabController = TabController(length: 2, vsync: this);

    initData();
    setGreeting();
  }

  // Initializes data by loading user information and device statuses
  void initData() async {
    try {
      isLoading.value = true;
      await loadUserData();

      // Check user rank and load appropriate data
      if (rank.value == 'OCC') {
        await getOCCRequestStatus();
        await getDeviceOCCUsed();
        await getOCCReturnStatus();
        await getAvailableDevices();
      } else {
        await checkingRequest();
        await getWaitingConfirmation();
        await getPilotHandover();
        await getInUse();
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Sets the greeting based on the current time of day
  void setGreeting() {
    final hour = DateTime.now().hour;
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

  /*
    |--------------------------------------------------------------------------
    | Line 134 - 356 is the EFB API handle from Pilot Request
    |--------------------------------------------------------------------------
    |
    | This section handles the API requests related to checking pilot requests,
    | loading user data, fetching available devices, and managing confirmation
    | statuses. It includes methods for checking requests, loading user data,
    | fetching available devices, and managing waiting confirmations and in-use
    | devices. Each method interacts with the API and updates the relevant
    | observable variables in the controller.
    |
    */

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

      log('ID Number: $userId');
      log('Hub: $hub');

      if (response.statusCode == 200) {
        log("Checking Request Response: ${response.body}");
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
    String hub = await _userPrefs.getHub();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_count_devices,
        ).replace(queryParameters: {'hub': hub}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        availableDevicesCount.value = responseData['data']['available'];
        usedDevicesCount.value = responseData['data']['used'];
      }
    } catch (e) {
      log('Error fetching available devices: $e');
      availableDevicesCount.value = 0;
      usedDevicesCount.value = 0;
    }
  }

  Future<void> getWaitingConfirmation() async {
    String token = await _userPrefs.getToken();
    String userId = await _userPrefs.getIdNumber();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_confirmation_status).replace(
          queryParameters: {'request_user': userId, 'status': 'waiting'},
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      log("Waiting Confirmation Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        waitingConfirmation.clear();
        waitingConfirmation.value = responseData['data'];
      } else {
        waitingConfirmation.clear();
      }
    } catch (e) {
      waitingConfirmation.clear();
      log('Error fetching waiting confirmation: $e');
    }
  }

  Future<void> getInUse() async {
    String token = await _userPrefs.getToken();
    String userId = await _userPrefs.getIdNumber();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_confirmation_status,
        ).replace(queryParameters: {'request_user': userId, 'status': 'used'}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      log("In Use Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        inUse.clear();
        inUse.value = responseData['data'];
      } else {
        inUse.clear();
      }
    } catch (e) {
      inUse.clear();
    }
  }

  Future<void> getPilotHandover() async {
    String token = await _userPrefs.getToken();
    String userId = await _userPrefs.getIdNumber();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_handover_device).replace(
          queryParameters: {
            'request_user': userId,
            'status': 'handover_confirmation',
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      log("Pilot Handover Response Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        pilotHandover.clear();
        pilotHandover.value = responseData['data'];
        log("Pilot Handover Data: ${pilotHandover.toString()}");
      } else {
        pilotHandover.clear();
      }
    } catch (e) {
      pilotHandover.clear();
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

  /*
    |--------------------------------------------------------------------------
    | Line 370 - 478 is the EFB API handle from OCC Request
    |--------------------------------------------------------------------------
    |
    | This section handles the API requests related to OCC requests, 
    | including fetching request statuses, device usage, and return statuses.
    | It includes methods for getting OCC request statuses, devices in use,
    | and return statuses.
    */

  Future<void> getOCCRequestStatus() async {
    String token = await _userPrefs.getToken();
    String hub = await _userPrefs.getHub();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_confirmation_occ,
        ).replace(queryParameters: {'hub': hub, 'status': 'waiting'}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        requestConfirmationOCC.clear();
        if (responseData['data'] != null) {
          requestConfirmationOCC.addAll(
            (responseData['data'] as List)
                .map((item) => item as Map<String, dynamic>)
                .toList(),
          );

          log("OCC Request Data: ${requestConfirmationOCC.toString()}");
        } else {
          requestConfirmationOCC.clear();
        }
      } else {
        requestConfirmationOCC.clear();
      }
    } catch (e) {
      log('Error fetching OCC request status: $e');
    }
  }

  Future<void> getDeviceOCCUsed() async {
    String token = await _userPrefs.getToken();
    String hub = await _userPrefs.getHub();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_confirmation_occ,
        ).replace(queryParameters: {'hub': hub, 'status': 'used'}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        deviceUsedOCC.clear();
        if (responseData['data'] != null) {
          deviceUsedOCC.addAll(
            (responseData['data'] as List)
                .map((item) => item as Map<String, dynamic>)
                .toList(),
          );
        } else {
          deviceUsedOCC.clear();
        }
      } else {
        deviceUsedOCC.clear();
      }
    } catch (e) {
      log('Error fetching OCC request status: $e');
    }
  }

  Future<void> getOCCReturnStatus() async {
    String token = await _userPrefs.getToken();
    String hub = await _userPrefs.getHub();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_confirmation_occ,
        ).replace(queryParameters: {'hub': hub, 'status': 'occ_returned'}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        returnConfirmationOCC.clear();
        if (responseData['data'] != null) {
          returnConfirmationOCC.addAll(
            (responseData['data'] as List)
                .map((item) => item as Map<String, dynamic>)
                .toList(),
          );
        } else {
          returnConfirmationOCC.clear();
        }
      } else {
        returnConfirmationOCC.clear();
      }
    } catch (e) {
      log('Error fetching OCC request status: $e');
    }
  }

  Future<void> refreshData() async {
    try {
      isLoading.value = true;

      await loadUserData();
      await checkingRequest();
      await getAvailableDevices();
      await getWaitingConfirmation();
      await getPilotHandover();
      await getInUse();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDataOCC() async {
    try {
      isLoading.value = true;
      await loadUserData();
      await getAvailableDevices();
      await getOCCRequestStatus();
      await getDeviceOCCUsed();
      await getOCCReturnStatus();
    } finally {
      isLoading.value = false;
    }
  }
}
