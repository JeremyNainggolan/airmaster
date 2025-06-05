import 'dart:convert';
import 'dart:typed_data';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Pilot_Handover_Controller extends GetxController {
  dynamic params = Get.arguments;

  final signatureKey = GlobalKey<SfSignaturePadState>();
  Uint8List? signatureImg;

  final device = {}.obs;
  final feedback = {}.obs;
  final user = {}.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
    if (params['feedback'] != null) {
      feedback.value = params['feedback'];
    }
  }

  Future<bool> getUser(String userId) async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_user_by_id,
        ).replace(queryParameters: {'id': userId}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final dynamic data = responseData['data'];
        if (data != null && data.isNotEmpty) {
          user.value = data[0];
          await Future.delayed(const Duration(seconds: 2));
          return true;
        }

        await Future.delayed(const Duration(seconds: 2));
        return false;
      } else {
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
