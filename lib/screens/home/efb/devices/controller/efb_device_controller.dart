import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/model/devices/device.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:screenshot/screenshot.dart';

/*
  |--------------------------------------------------------------------------
  | File: EFB Device Controller
  |--------------------------------------------------------------------------
  | This controller handles the logic for managing EFB devices, including
  | fetching data from the API, performing search based on user input, and
  | managing loading state. It also supports screenshot capture functionality
  | for UI components.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-27
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class EFB_Device_Controller extends GetxController {
  final List<Device> device = <Device>[].obs;

  List<Device> foundedDevices = <Device>[].obs;

  final textSearchField = TextEditingController();

  final screenshotController = ScreenshotController();

  final captureKey = GlobalKey();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDevice();
    foundedDevices = device;
  }

  /// Refreshes the device data by fetching the latest device information.
  ///
  /// This method asynchronously calls [getDevice] to retrieve the current device data,
  /// and then updates [foundedDevices] with the newly fetched device.
  ///
  /// Returns a [Future] that completes when the data has been refreshed.
  Future<void> refreshData() async {
    await getDevice();
    foundedDevices = device;
  }

  /// Fetches the list of devices associated with the current user's hub.
  ///
  /// This method sets the [isLoading] flag to `true` while fetching data.
  /// It retrieves the authentication token and hub identifier from [UserPreferences].
  /// Then, it sends an HTTP GET request to the devices API endpoint with the required headers.
  /// If the response is successful (status code 200), it parses the device data and updates the [device] list.
  /// In case of failure or error, it logs the appropriate message.
  /// Finally, it sets the [isLoading] flag to `false`.
  ///
  /// Throws no exceptions; errors are logged internally.
  Future<void> getDevice() async {
    isLoading.value = true;

    String token = await UserPreferences().getToken();
    String hub = await UserPreferences().getHub();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_devices).replace(queryParameters: {'hub': hub}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        device.clear();
        device.addAll(
          (responseData['data'] as List)
              .map((device) => Device.fromJson(device))
              .toList(),
        );
      } else {
        log('Failed to fetch devices: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching device data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Filters the list of devices based on the provided [query].
  ///
  /// If [query] is empty, all devices are returned. Otherwise, only devices
  /// whose [deviceNo] contains the [query] (case-insensitive) are included
  /// in the [foundedDevices] list.
  ///
  /// [query]: The search string used to filter devices.
  void searchDevice(String query) {
    if (query.isEmpty) {
      foundedDevices = device;
    } else {
      foundedDevices =
          device.where((device) {
            return device.deviceNo.toLowerCase().contains(query.toLowerCase());
          }).toList();
    }
  }

  /// Returns the [Device] object that matches the given [deviceNo].
  ///
  /// Searches the list of devices and returns the first device whose
  /// [deviceNo] property matches the provided [deviceNo].
  ///
  /// Throws a [StateError] if no matching device is found.
  Device getDeviceById(String deviceNo) {
    return device.firstWhere((device) => device.deviceNo == deviceNo);
  }
}
