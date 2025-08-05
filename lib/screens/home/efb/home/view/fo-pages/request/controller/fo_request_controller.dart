import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/model/devices/device.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: FO Request Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling FO Request operations.
  | It manages the state and logic for FO Request, including device selection
  | and request submission.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-06
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Request_Controller extends GetxController {
  final mainDevice = false.obs;
  final searchMainDevice = TextEditingController();
  final mainDeviceNo = ''.obs;
  final mainDeviceiOSVersion = ''.obs;
  final mainDeviceFlySmart = ''.obs;
  final mainDeviceDocuVersion = ''.obs;
  final mainDeviceLidoVersion = ''.obs;
  final mainDeviceHub = ''.obs;
  final mainDeviceCategory = 'Good'.obs;
  final mainDeviceRemark = ''.obs;

  final backupDevice = false.obs;
  final searchBackupDevice = TextEditingController();
  final backupDeviceNo = ''.obs;
  final backupDeviceiOSVersion = ''.obs;
  final backupDeviceFlySmart = ''.obs;
  final backupDeviceDocuVersion = ''.obs;
  final backupDeviceLidoVersion = ''.obs;
  final backupDeviceHub = ''.obs;
  final backupDeviceCategory = 'Good'.obs;
  final backupDeviceRemark = ''.obs;

  /// Retrieves a list of [Device] objects by searching for a device name.
  ///
  /// This function sends an HTTP GET request to the API endpoint specified in [ApiConfig.get_device_by_name],
  /// including the device number (`searchDevice`) and hub as query parameters. The request includes an
  /// authorization token in the headers.
  ///
  /// Returns a [Future] that completes with a list of [Device] objects matching the search criteria.
  /// If the request fails or no devices are found, an empty list is returned.
  ///
  /// Throws no exceptions; any errors are caught and result in an empty list being returned.
  ///
  /// - [searchDevice]: The name or number of the device to search for.
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
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  /// Retrieves a [Device] object by its ID from the server.
  ///
  /// Makes an HTTP GET request to the API endpoint specified in [ApiConfig.get_device_by_id],
  /// passing the device number ([searchDevice]) and hub as query parameters. The request includes
  /// an authorization token in the headers.
  ///
  /// Returns a [Device] if found, or `null` if no device matches the given ID, the response is invalid,
  /// or an error occurs during the request.
  ///
  /// Throws no exceptions; all errors are caught and result in a `null` return value.
  ///
  /// - [searchDevice]: The device number to search for.
  ///
  /// Example usage:
  /// ```dart
  /// Device? device = await getDeviceById('12345');
  /// ```
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
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Sets the main device information and updates relevant fields.
  ///
  /// This method assigns the provided [device] as the main device by:
  /// - Setting [mainDevice] to `true`.
  /// - Updating [searchMainDevice] text with the device number.
  /// - Assigning device properties such as device number, iOS version,
  ///   FlySmart version, Docu version, Lido version, and hub to their
  ///   respective observable fields.
  ///
  /// [device] - The [Device] object containing the main device details.
  void setMainDevice(Device device) {
    mainDevice.value = true;
    searchMainDevice.text = device.deviceNo;
    mainDeviceNo.value = device.deviceNo;
    mainDeviceiOSVersion.value = device.iosVersion;
    mainDeviceFlySmart.value = device.flySmart;
    mainDeviceDocuVersion.value = device.docuVersion;
    mainDeviceLidoVersion.value = device.lidoVersion;
    mainDeviceHub.value = device.hub;
  }

  /// Clears all fields related to the main device, resetting their values to defaults.
  ///
  /// This includes:
  /// - Setting `mainDevice` to `false`
  /// - Clearing the search field for the main device
  /// - Resetting device number, iOS version, FlySmart version, Docu version, Lido version, hub, and remark to empty strings
  /// - Setting device category to `'Good'`
  void clearMainDevice() {
    mainDevice.value = false;
    searchMainDevice.clear();
    mainDeviceNo.value = '';
    mainDeviceiOSVersion.value = '';
    mainDeviceFlySmart.value = '';
    mainDeviceDocuVersion.value = '';
    mainDeviceLidoVersion.value = '';
    mainDeviceHub.value = '';
    mainDeviceCategory.value = 'Good';
    mainDeviceRemark.value = '';
  }

  /// Sets the backup device information using the provided [device].
  ///
  /// Updates the following backup device properties:
  /// - [backupDevice]: Marks the backup device as active.
  /// - [searchBackupDevice]: Sets the device number for search.
  /// - [backupDeviceNo]: Stores the device number.
  /// - [backupDeviceiOSVersion]: Stores the iOS version of the device.
  /// - [backupDeviceFlySmart]: Stores the FlySmart version.
  /// - [backupDeviceDocuVersion]: Stores the Docu version.
  /// - [backupDeviceLidoVersion]: Stores the Lido version.
  /// - [backupDeviceHub]: Stores the hub information.
  void setBackupDevice(Device device) {
    backupDevice.value = true;
    searchBackupDevice.text = device.deviceNo;
    backupDeviceNo.value = device.deviceNo;
    backupDeviceiOSVersion.value = device.iosVersion;
    backupDeviceFlySmart.value = device.flySmart;
    backupDeviceDocuVersion.value = device.docuVersion;
    backupDeviceLidoVersion.value = device.lidoVersion;
    backupDeviceHub.value = device.hub;
  }

  /// Clears all backup device-related fields by resetting their values to default.
  ///
  /// This method sets the backup device status to `false`, clears the search field,
  /// and resets all backup device details such as device number, iOS version,
  /// FlySmart version, Docu version, Lido version, hub, category, and remark.
  /// The category is set to 'Good' by default.
  void clearBackupDevice() {
    backupDevice.value = false;
    searchBackupDevice.clear();
    backupDeviceNo.value = '';
    backupDeviceiOSVersion.value = '';
    backupDeviceFlySmart.value = '';
    backupDeviceDocuVersion.value = '';
    backupDeviceLidoVersion.value = '';
    backupDeviceHub.value = '';
    backupDeviceCategory.value = 'Good';
    backupDeviceRemark.value = '';
  }

  /// Submits a FO (First Officer) request to the server.
  ///
  /// This method gathers device and user information, constructs a request payload,
  /// and sends it via HTTP POST to the FO request submission endpoint.
  ///
  /// Returns `true` if the request was successfully submitted (HTTP 200 response),
  /// otherwise returns `false`.
  ///
  /// The request payload includes:
  /// - Device information for both main and backup devices (number, iOS version, FlySmart, DocuVersion, LidoVersion, Hub, Category, Remark)
  /// - User information (ID number, name)
  /// - Request metadata (date, status)
  ///
  /// Throws no exceptions; any error during submission will result in a `false` return value.
  Future<bool> submitRequest() async {
    String token = await UserPreferences().getToken();
    String requestUser = await UserPreferences().getIdNumber();
    String requestUserName = await UserPreferences().getName();

    final data = {
      'isFoRequest': 'true',
      'mainDeviceNo': mainDeviceNo.value,
      'mainDeviceiOSVersion': mainDeviceiOSVersion.value,
      'mainDeviceFlySmart': mainDeviceFlySmart.value,
      'mainDeviceDocuVersion': mainDeviceDocuVersion.value,
      'mainDeviceLidoVersion': mainDeviceLidoVersion.value,
      'mainDeviceHub': mainDeviceHub.value,
      'mainDeviceCategory': mainDeviceCategory.value,
      'mainDeviceRemark': mainDeviceRemark.value,
      'backupDeviceNo': backupDeviceNo.value,
      'backupDeviceiOSVersion': backupDeviceiOSVersion.value,
      'backupDeviceFlySmart': backupDeviceFlySmart.value,
      'backupDeviceDocuVersion': backupDeviceDocuVersion.value,
      'backupDeviceLidoVersion': backupDeviceLidoVersion.value,
      'backupDeviceHub': backupDeviceHub.value,
      'backupDeviceCategory': backupDeviceCategory.value,
      'backupDeviceRemark': backupDeviceRemark.value,
      'request_user': requestUser,
      'request_user_name': requestUserName,
      'request_date': DateTime.now().toString(),
      'status': 'waiting',
    };

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.fo_submit_request),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
