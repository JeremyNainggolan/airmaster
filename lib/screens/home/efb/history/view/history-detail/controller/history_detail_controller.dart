import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class History_Detail_Controller extends GetxController {
  dynamic params = Get.arguments;

  final detail = {}.obs;

  Rx<Uint8List?> img = Rx<Uint8List?>(null);

  @override
  void onInit() {
    super.onInit();
    detail.value = params['detail'];
  }

  Future<void> getImage(String imgName) async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_device_image,
        ).replace(queryParameters: {'img_name': imgName}),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        img.value = response.bodyBytes;
        log('Image fetched successfully: ${img.value?.length} bytes');
      }
    } catch (e) {
      log('Error fetching image: $e');
    }
  }
}
