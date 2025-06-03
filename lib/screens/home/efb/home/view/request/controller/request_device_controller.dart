// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/model/devices/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Request_Controller extends GetxController {
  final requestDevice = TextEditingController();
  final selectedDevice = false.obs;
  final selectedDeviceNo = ''.obs;
  final selectediOSVersion = ''.obs;
  final selectedFlySmart = ''.obs;
  final selectedDocuVersion = ''.obs;
  final selectedLidoVersion = ''.obs;
  final selectedHub = ''.obs;
  final category = 'Good'.obs;
  final remark = ''.obs;

  Future<bool> submitRequest() async {
    String token = await UserPreferences().getToken();
    String requestUser = await UserPreferences().getIdNumber();
    String requestUserName = await UserPreferences().getName();

    final data = {
      'deviceno': selectedDeviceNo.value,
      'iosver': selectediOSVersion.value,
      'flysmart': selectedFlySmart.value,
      'docuversion': selectedDocuVersion.value,
      'lidoversion': selectedLidoVersion.value,
      'hub': selectedHub.value,
      'category': category.value,
      'remark': remark.value,
      'request_user': requestUser,
      'request_user_name': requestUserName,
      'request_date': DateTime.now().toString(),
      'status': 'waiting',
    };

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.submit_request),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: data,
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log("Request submitted successfully: ${responseData['message']}");
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        log("API Error: ${responseData['message']}");
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<Device>> getDeviceByName(String searchDevice) async {
    String token = await UserPreferences().getToken();
    String hub = await UserPreferences().getHub();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_device_by_name,
        ).replace(queryParameters: {'deviceno': searchDevice, 'hub': hub}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var deviceRaw = responseData['data']['device'];
        List<Device> devices = Device.resultSearchJson(deviceRaw);
        return devices;
      } else {
        log("API Error: ${response.body}");
        return [];
      }
    } catch (e) {
      log("Exception in getUsersBySearchName: $e");
      return [];
    }
  }

  Future<Device?> getDeviceById(String searchDevice) async {
    String token = await UserPreferences().getToken();
    String hub = await UserPreferences().getHub();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_device_by_id,
        ).replace(queryParameters: {'deviceno': searchDevice, 'hub': hub}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> dataList = responseData['data'];
        if (dataList.isNotEmpty) {
          Device device = Device.fromJson(dataList[0]);
          return device;
        } else {
          log("Data kosong");
          return null;
        }
      } else {
        log("API Error: ${response.body}");
        return null;
      }
    } catch (e) {
      log("Exception in getUsersBySearchName: $e");
      return null;
    }
  }
}
