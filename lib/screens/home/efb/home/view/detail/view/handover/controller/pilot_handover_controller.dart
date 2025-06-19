import 'dart:convert';
import 'dart:typed_data';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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

  Future<bool> saveHandover() async {
    String token = await UserPreferences().getToken();

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.pilot_handover),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['request_id'] = device['id']['\$oid'];
      request.fields['request_user'] = device['request_user'];
      request.fields['handover_to'] = user['id_number'];
      request.fields['handover_date'] = DateTime.now().toString();
      if (feedback.isNotEmpty) {
        request.fields['feedback'] = jsonEncode(feedback);
      }
      request.files.add(
        http.MultipartFile.fromBytes(
          'signature',
          signatureImg!,
          filename: 'signature_${device['request_user']}.png',
          contentType: MediaType('image', 'png'),
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 2));
      return true;
    }
  }
}
