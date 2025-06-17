import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Handover_Log_Format_Controller extends GetxController {
  final format = {}.obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  final recNumberController = TextEditingController();
  final dateController = TextEditingController();
  final footerLeftController = TextEditingController();
  final footerRightController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadFormat();
  }

  Future<void> loadFormat() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final token = await UserPreferences().getToken();
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_format_pdf,
        ).replace(queryParameters: {'id': 'handover-log'}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        format.value = responseData['data'];
        recNumberController.text = format['rec_number'];
        dateController.text = format['date'] ?? '';
        footerLeftController.text = format['left_footer'];
        footerRightController.text = format['right_footer'];
      } else {
        errorMessage.value = 'Failed to load format, contact your IT Support';
        format.clear();
      }
    } catch (e) {
      format.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> saveFormat() async {
    String token = await UserPreferences().getToken();

    try {
      final data = {
        'id': format['id'],
        'rec_number': recNumberController.text,
        'date': dateController.text,
        'left_footer': footerLeftController.text,
        'right_footer': footerRightController.text,
      };

      final response = await http.post(
        Uri.parse(ApiConfig.update_format_pdf),
        body: jsonEncode(data),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(milliseconds: 1500));
        return true;
      }
      await Future.delayed(const Duration(milliseconds: 1500));
      return false;
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 1500));
      return false;
    }
  }

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorConstants.primaryColor,
              onPrimary: ColorConstants.whiteColor,
              surface: ColorConstants.whiteColor,
              onSurface: ColorConstants.blackColor,
              onSecondary: ColorConstants.secondaryColor,
              brightness: Brightness.light,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorConstants.activeColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      dateController.text = DateFormatter.convertDateTimeDisplay(
        pickedDate.toString(),
        'dd MMMM yyyy',
      );
    } else {
      dateController.clear();
    }
  }
}
