// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EFB_History_Controller extends GetxController {
  final RxList<dynamic> history = <dynamic>[].obs;
  final RxList<dynamic> filteredHistory = <dynamic>[].obs;

  final RxBool doneCheckBox = false.obs;
  final RxBool handoverCheckBox = false.obs;

  final TextEditingController textSearchField = TextEditingController();
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();

  final rank = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getHistory();
    loadUserData();
  }

  Future<void> refreshData() async {
    await getHistory();
    await loadUserData();
  }

  Future<void> loadUserData() async {
    rank.value = await UserPreferences().getRank();
  }

  Future<void> getHistory() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_history),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['data'] != null) {
        history.assignAll(responseData['data']);
        filteredHistory.assignAll(responseData['data']);
      } else {
        log('Failed to fetch history: ${response.statusCode}');
        Get.snackbar(
          'Error',
          'Failed to fetch history (${response.statusCode})',
        );
      }
    } catch (e) {
      log('Error fetching history data: $e');
      Get.snackbar('Error', 'Failed to connect to server');
    }
  }

  Future<void> selectFromDate() async {
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
      fromDate.text = DateFormatter.convertDateTimeDisplay(
        pickedDate.toString(),
        'dd MMMM yyyy',
      );
    } else {
      fromDate.clear();
    }
  }

  Future<void> selectToDate() async {
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
      toDate.text = DateFormatter.convertDateTimeDisplay(
        pickedDate.toString(),
        'dd MMMM yyyy',
      );
    } else {
      toDate.clear();
    }
  }

  DateTime? parseCustomDate(String input) {
    try {
      return DateFormatter.convertToDate(input, 'dd MMMM yyyy');
    } catch (_) {
      return null;
    }
  }

  void searchHistory(String query) {
    if (query.isEmpty) {
      filteredHistory.assignAll(history);
    } else {
      final result =
          history.where((h) {
            return h['request_user_name'].toString().toLowerCase().contains(
              query.toLowerCase(),
            );
          }).toList();

      filteredHistory.assignAll(result);
    }
  }

  void applyFilter() {
    DateTime from = DateTime(0);
    DateTime to = DateTime.now();

    final parsedFrom =
        fromDate.text.isNotEmpty
            ? DateFormatter.convertToDate(fromDate.text, 'dd MMMM yyyy')
            : null;
    if (parsedFrom != null) from = parsedFrom;

    final parsedTo =
        toDate.text.isNotEmpty
            ? DateFormatter.convertToDate(toDate.text, 'dd MMMM yyyy')
            : null;
    if (parsedTo != null) to = parsedTo;

    final result =
        history.where((history) {
          final requestDate = DateTime.tryParse(history['request_date']);
          if (requestDate == null) return false;

          final matchDate =
              !requestDate.isBefore(from) && !requestDate.isAfter(to);
          final matchDone =
              doneCheckBox.value ? history['status'] == 'returned' : true;
          final matchHandover =
              handoverCheckBox.value
                  ? history['handover_status'] == 'handover'
                  : true;

          return matchDate && matchDone && matchHandover;
        }).toList();

    filteredHistory.assignAll(result);
    log('Filtered history: ${result.length} items');
  }

  void resetFilter() {
    doneCheckBox.value = false;
    handoverCheckBox.value = false;
    textSearchField.clear();
    fromDate.clear();
    toDate.clear();
    filteredHistory.assignAll(history);
  }
}
