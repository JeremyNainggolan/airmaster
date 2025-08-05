import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/*
  |--------------------------------------------------------------------------
  | File: Format PDF Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling format PDF operations.
  | It manages the state and logic for format PDF requests.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-01
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Format_Pdf_Controller extends GetxController {
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

  /// Loads the PDF format data for the feedback form.
  ///
  /// This method sets the loading state, clears any previous error messages,
  /// and attempts to fetch the format data from the API using the user's token.
  /// On a successful response (HTTP 200), it updates the format and associated
  /// text controllers with the received data. If the request fails or an error
  /// occurs, it clears the format and sets an appropriate error message.
  /// The loading state is reset after the operation completes.
  Future<void> loadFormat() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final token = await UserPreferences().getToken();
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_format_pdf,
        ).replace(queryParameters: {'id': 'feedback-form'}),
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
  /// This method collects the format data from the controllers and sends a POST request
  /// to the API endpoint specified in [ApiConfig.update_format_pdf]. The request includes
  /// an authorization token and the format data in JSON format.
  ///
  /// Returns `true` if the format is saved successfully (HTTP 200), otherwise returns `false`.
  /// In case of an error during the request, logs the error and returns `false`.
  ///
  /// Adds a delay of 1500 milliseconds after the request for UI feedback purposes.
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
        log('Format saved successfully');
        return true;
      }
      await Future.delayed(const Duration(milliseconds: 1500));
      log('Failed to save format: ${response.body}');
      return false;
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 1500));
      log('Error saving format: $e');
      return false;
    }
  }

  /// Displays a date picker dialog for the user to select a date.
  ///
  /// The date picker is themed according to the application's color scheme.
  /// The selectable date range is from 10 years ago to 10 years in the future.
  ///
  /// If a date is selected, it formats the date as 'dd MMMM yyyy' and sets it to [dateController].
  /// If no date is selected, it clears the [dateController].
  ///
  /// Uses [Get.context] for the dialog context and relies on [ColorConstants] for theming.
  ///
  /// Throws no exceptions.
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
