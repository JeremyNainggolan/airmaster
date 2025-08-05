import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: Handover Log Format Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling the Handover Log Format.
  | It is responsible for fetching format data, formatting it, and generating PDF documents.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-01
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
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

  /// Loads the handover log format from the server.
  ///
  /// Sets [isLoading] to `true` while fetching data and resets [errorMessage].
  /// Retrieves the authentication token and sends a GET request to the API endpoint
  /// to fetch the format PDF data for the handover log.
  ///
  /// On a successful response (`statusCode == 200`), updates [format] with the received data
  /// and populates the corresponding controllers ([recNumberController], [dateController],
  /// [footerLeftController], [footerRightController]) with the format values.
  ///
  /// If the request fails, sets an error message and clears [format].
  /// In case of any exception, clears [format].
  /// Finally, sets [isLoading] to `false`.
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

  /// Saves the current format data to the server.
  ///
  /// This method collects data from the controllers and sends a POST request
  /// to update the format PDF using the provided API endpoint. It includes
  /// authentication via a bearer token and sends the data as JSON.
  ///
  /// Returns `true` if the request is successful (HTTP 200), otherwise returns `false`.
  /// In both success and failure cases, there is a delay of 1500 milliseconds before returning.
  ///
  /// Throws an exception if an error occurs during the process.
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

  /// Displays a date picker dialog for the user to select a date.
  ///
  /// The date picker is themed according to the application's color scheme.
  /// The selectable date range is from 10 years ago to 10 years in the future.
  /// If a date is selected, it is formatted as 'dd MMMM yyyy' and set to [dateController].
  /// If no date is selected, the [dateController] is cleared.
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
