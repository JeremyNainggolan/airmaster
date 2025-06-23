import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/model/devices/device.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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
