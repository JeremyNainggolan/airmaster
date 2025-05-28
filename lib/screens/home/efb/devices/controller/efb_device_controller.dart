// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/model/devices/device.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:screenshot/screenshot.dart';

class EFB_Device_Controller extends GetxController {
  final List<Device> device = <Device>[].obs;
  List<Device> foundedDevices = <Device>[].obs;
  final textSearchField = TextEditingController();
  final isLoading = false.obs;

  final screenshotController = ScreenshotController();
  final captureKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    getDevice();
    foundedDevices = device;
  }

  Future<void> getDevice() async {
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
    }
  }

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

  Device getDeviceById(String deviceNo) {
    return device.firstWhere((device) => device.deviceNo == deviceNo);
  }
}
