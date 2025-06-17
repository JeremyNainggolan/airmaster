import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OCC_Requested_Controller extends GetxController {
  dynamic params = Get.arguments;

  final device = {}.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }

  Future<bool> reject() async {
    String token = await UserPreferences().getToken();
    String userId = await UserPreferences().getIdNumber();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.reject_request_device).replace(
          queryParameters: {
            'request_id': device['id']['\$oid'],
            'rejected_by': userId,
            'rejected_at': DateTime.now().toString(),
            'deviceno': device['deviceno'],
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 2));
      return false;
    }
  }

  Future<bool> approve() async {
    String token = await UserPreferences().getToken();
    String userId = await UserPreferences().getIdNumber();

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.approve_request_device),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'request_id': device['id']['\$oid'],
          'approved_by': userId,
          'approved_at': DateTime.now().toString(),
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        log('Failed to fetch devices: ${response.statusCode}');
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }
    } catch (e) {
      log('Error: $e');
      await Future.delayed(const Duration(seconds: 2));
      return false;
    }
  }
}
