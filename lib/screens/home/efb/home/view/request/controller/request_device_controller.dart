// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/model/devices/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: Request Device Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling device requests.
  | It manages the state and logic for submitting device requests,
  | including selecting devices and submitting request details.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-02
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
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

  /// Submits a device request to the server.
  ///
  /// This method gathers user and device information, constructs a request payload,
  /// and sends it via an HTTP POST request to the API endpoint specified in [ApiConfig.submit_request].
  /// The request includes device details, user information, and other relevant fields.
  ///
  /// Returns `true` if the request is successfully submitted (HTTP status 200),
  /// otherwise returns `false`. In case of an exception during the request,
  /// it also returns `false`.
  ///
  /// The method logs the result of the submission for debugging purposes.
  ///
  /// Example usage:
  /// ```dart
  /// bool success = await submitRequest();
  /// ```
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

  /// Fetches a list of [Device] objects by searching with the provided [searchDevice] name.
  ///
  /// Retrieves the authentication token and hub information from [UserPreferences].
  /// Sends a GET request to the API endpoint specified in [ApiConfig.get_device_by_name],
  /// including the device number and hub as query parameters.
  ///
  /// Returns a [Future] that resolves to a list of [Device] objects if the request is successful.
  /// If the API response status is not 200 or an exception occurs, returns an empty list.
  ///
  /// Logs errors and exceptions for debugging purposes.
  ///
  /// [searchDevice]: The device name or number to search for.
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

  /// Retrieves a [Device] by its ID from the API.
  ///
  /// This method sends a GET request to the API endpoint specified in [ApiConfig.get_device_by_id],
  /// including the device number (`searchDevice`) and hub information as query parameters.
  /// The request includes an authorization token in the headers.
  ///
  /// Returns a [Device] object if found, or `null` if no device is found or an error occurs.
  ///
  /// Logs an error message if the API response is not successful or if an exception is thrown.
  ///
  /// [searchDevice]: The device number to search for.
  ///
  /// Throws no exceptions; all errors are handled internally and logged.
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
