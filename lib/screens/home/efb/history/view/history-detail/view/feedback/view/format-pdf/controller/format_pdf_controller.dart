import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Format_Pdf_Controller extends GetxController {
  final format = {}.obs;

  @override
  void onInit() async {
    super.onInit();
    await loadFormat();
  }

  Future<void> loadFormat() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_feedback_format_pdf),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        format.value = responseData['data'];
        log('Format loaded successfully');
      } else {
        log('Failed to load format: ${response.statusCode}');
      }
    } catch (e) {
      log('Error loading format: $e');
    }
  }
}
