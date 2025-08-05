import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

/*
  |--------------------------------------------------------------------------
  | File: EFB History Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for managing EFB history data.
  | It handles fetching, filtering, and exporting history data. 
  | It also manages user preferences and date selection for filtering.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-27
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class EFB_History_Controller extends GetxController {
  final RxList<dynamic> occHistory = <dynamic>[].obs;
  final RxList<dynamic> occFilteredHistory = <dynamic>[].obs;

  final RxList<dynamic> otherHistory = <dynamic>[].obs;
  final RxList<dynamic> otherFilteredHistory = <dynamic>[].obs;

  final RxBool doneCheckBox = false.obs;
  final RxBool handoverCheckBox = false.obs;

  final TextEditingController textSearchField = TextEditingController();

  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();

  final isLoading = false.obs;

  final rank = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    getOccHistory();
    getOtherHistory();
  }

  Future<void> refreshData() async {
    await loadUserData();
    await getOccHistory();
    await getOtherHistory();
  }

  /// Loads the user's rank data asynchronously and updates the [rank] value.
  ///
  /// Retrieves the user's rank from [UserPreferences] and assigns it to [rank].
  /// Logs the retrieved rank for debugging purposes.
  Future<void> loadUserData() async {
    rank.value = await UserPreferences().getRank();
    log('User rank: $rank');
  }

  /// Fetches OCC history data from the API and updates the history lists.
  ///
  /// This method sets the [isLoading] flag to `true` while fetching data.
  /// It retrieves the user's token from [UserPreferences], then sends a GET request
  /// to the history API endpoint. If the response is successful and contains data,
  /// it updates both [occHistory] and [occFilteredHistory] with the received data.
  /// Any errors encountered during the fetch are logged. The [isLoading] flag is
  /// reset to `false` after the operation completes, regardless of success or failure.
  Future<void> getOccHistory() async {
    isLoading.value = true;
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
        occHistory.assignAll(responseData['data']);
        occFilteredHistory.assignAll(responseData['data']);
      }
    } catch (e) {
      log('Error fetching history data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetches the history data for other users asynchronously.
  ///
  /// This method sets the loading state to true, retrieves the authentication token
  /// and user ID from user preferences, and sends a GET request to the API endpoint
  /// to fetch other users' history data. The request includes the token in the
  /// Authorization header and the user ID as a query parameter.
  ///
  /// If the response is successful and contains data, it assigns the fetched data
  /// to both `otherHistory` and `otherFilteredHistory` lists, and logs the number
  /// of items fetched along with the data. In case of an error during the fetch,
  /// it logs the error message. The loading state is reset to false after the
  /// operation completes, regardless of success or failure.
  Future<void> getOtherHistory() async {
    isLoading.value = true;
    String token = await UserPreferences().getToken();
    String userId = await UserPreferences().getIdNumber();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_other_history,
        ).replace(queryParameters: {'request_user': userId}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['data'] != null) {
        otherHistory.assignAll(responseData['data']);
        otherFilteredHistory.assignAll(responseData['data']);
        log('Other history data fetched: ${otherHistory.length} items');
        log('Data: ${otherHistory.toString()}');
      }
    } catch (e) {
      log('Error fetching history data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Displays a date picker dialog for selecting the "from" date.
  ///
  /// The date picker is themed according to the application's color scheme.
  /// The selectable date range is from 10 years ago to 10 years in the future.
  /// If a date is picked, it is formatted as 'dd MMMM yyyy' and set to [fromDate].
  /// If no date is picked, [fromDate] is cleared.
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

  /// Displays a date picker dialog for selecting the "to" date.
  ///
  /// The date picker is themed according to the application's color scheme.
  /// The selectable date range is from 10 years ago to 10 years in the future.
  /// If a date is selected, it is formatted as 'dd MMMM yyyy' and set to [toDate].
  /// If no date is selected, [toDate] is cleared.
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

  /// Parses a date string in the format 'dd MMMM yyyy' and returns a [DateTime] object.
  ///
  /// If the parsing fails, returns `null`.
  ///
  /// Example:
  /// ```dart
  /// final date = parseCustomDate('12 January 2024');
  /// // date == DateTime(2024, 1, 12)
  /// ```
  DateTime? parseCustomDate(String input) {
    try {
      return DateFormatter.convertToDate(input, 'dd MMMM yyyy');
    } catch (_) {
      return null;
    }
  }

  /// Filters the `occHistory` list based on the provided [query].
  ///
  /// If [query] is empty, all history items are assigned to `occFilteredHistory`.
  /// Otherwise, only items where the `request_user_name` contains the [query]
  /// (case-insensitive) are included in `occFilteredHistory`.
  ///
  /// [query] The search string used to filter history items.
  void searchHistory(String query) {
    if (query.isEmpty) {
      occFilteredHistory.assignAll(occHistory);
    } else {
      final result =
          occHistory.where((h) {
            return h['request_user_name'].toString().toLowerCase().contains(
              query.toLowerCase(),
            );
          }).toList();

      occFilteredHistory.assignAll(result);
    }
  }

  /// Filters the `otherHistory` list based on the provided [query].
  ///
  /// Other history is specifically for Pilot and FO (First Officer) users.
  ///
  /// If [query] is empty, all items from `otherHistory` are assigned to
  /// `otherFilteredHistory`. Otherwise, only items where the
  /// `'request_user_name'` field contains the [query] (case-insensitive)
  /// are included in `otherFilteredHistory`.
  ///
  /// [query] The search string used to filter the history.
  void searchOtherHistory(String query) {
    if (query.isEmpty) {
      otherFilteredHistory.assignAll(otherHistory);
    } else {
      final result =
          otherHistory.where((h) {
            return h['request_user_name'].toString().toLowerCase().contains(
              query.toLowerCase(),
            );
          }).toList();

      otherFilteredHistory.assignAll(result);
    }
  }

  /// Applies filters to the occurrence history based on selected date range,
  /// status, and handover status.
  ///
  /// The method parses the `fromDate` and `toDate` text fields to determine
  /// the filtering date range. If the fields are empty, it defaults to the
  /// earliest possible date (`DateTime(0)`) for `from` and the current date
  /// for `to`.
  ///
  /// It then filters `occHistory` by:
  /// - Checking if the `request_date` falls within the specified date range.
  /// - If `doneCheckBox` is checked, only includes items with status 'returned'.
  /// - If `handoverCheckBox` is checked, only includes items with handover status 'handover'.
  ///
  /// The filtered results are assigned to `occFilteredHistory`, and the number
  /// of filtered items is logged.
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
        occHistory.where((history) {
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

    occFilteredHistory.assignAll(result);
    log('Filtered history: ${result.length} items');
  }

  void resetFilter() {
    doneCheckBox.value = false;
    handoverCheckBox.value = false;
    textSearchField.clear();
    fromDate.clear();
    toDate.clear();
    occFilteredHistory.assignAll(occHistory);
  }

  /// Exports the filtered OCC history data to an Excel file.
  ///
  /// This method creates an Excel file with a sheet named 'History' and appends a header row
  /// followed by rows containing data from `occFilteredHistory`. Each row represents a history
  /// record with crew, device, and handover details. The Excel file is saved to the application's
  /// documents directory as 'history_export.xlsx' and opened automatically after saving.
  ///
  /// Returns `true` if the export is successful.
  /// Throws an [Exception] if an error occurs during the export process.
  Future<bool> exportToExcel() async {
    try {
      var excel = Excel.createExcel();

      Sheet sheet;
      if (excel.sheets.isEmpty) {
        sheet = excel['History'];
      } else {
        sheet = excel['History'];
      }

      final header = [
        TextCellValue('Crew ID'),
        TextCellValue('Crew Name'),
        TextCellValue('Crew Rank'),
        TextCellValue('Crew Hub'),
        TextCellValue('Device 1'),
        TextCellValue('iOS Version (1st)'),
        TextCellValue('Flysmart Version (1st)'),
        TextCellValue('Docunet Version (1st)'),
        TextCellValue('LiDo Version (1st)'),
        TextCellValue('Device Hub (1st)'),
        TextCellValue('Device Condition (1st)'),
        TextCellValue('Device 2'),
        TextCellValue('iOS Version (2nd)'),
        TextCellValue('Flysmart Version (2nd)'),
        TextCellValue('Docunet Version (2nd)'),
        TextCellValue('LiDo Version (2nd)'),
        TextCellValue('Device Hub (2nd)'),
        TextCellValue('Device Condition (2nd)'),
        TextCellValue('Device 3'),
        TextCellValue('iOS Version (3rd)'),
        TextCellValue('Flysmart Version (3rd)'),
        TextCellValue('Docunet Version (3rd)'),
        TextCellValue('LiDo Version (3rd)'),
        TextCellValue('Device Hub (3rd)'),
        TextCellValue('Device Condition (3rd)'),
        TextCellValue('Status'),
        TextCellValue('OCC On Duty (ID)'),
        TextCellValue('OCC On Duty (Name)'),
        TextCellValue('OCC On Duty (Hub)'),
        TextCellValue('OCC Accept (ID)'),
        TextCellValue('OCC Accept (Name)'),
        TextCellValue('OCC Accept (Hub)'),
        TextCellValue('Handover To (ID)'),
        TextCellValue('Handover To (Name)'),
        TextCellValue('Handover To (Rank)'),
        TextCellValue('Handover To (Hub)'),
      ];

      sheet.appendRow(header);

      for (var item in occFilteredHistory) {
        final row = [
          TextCellValue(item['request_user'] ?? '-'),
          TextCellValue(item['request_user_name'] ?? '-'),
          TextCellValue(item['request_user_rank'] ?? '-'),
          TextCellValue(item['request_user_hub'] ?? '-'),
          TextCellValue(item['deviceno'] ?? '-'),
          TextCellValue(item['ios_version'] ?? '-'),
          TextCellValue(item['fly_smart'] ?? '-'),
          TextCellValue(item['doc_version'] ?? '-'),
          TextCellValue(item['lido_version'] ?? '-'),
          TextCellValue(item['hub'] ?? '-'),
          TextCellValue(item['category'] ?? '-'),
          TextCellValue(item['mainDeviceNo'] ?? '-'),
          TextCellValue(item['mainDeviceiOSVersion'] ?? '-'),
          TextCellValue(item['mainDeviceFlySmart'] ?? '-'),
          TextCellValue(item['mainDeviceDocuVersion'] ?? '-'),
          TextCellValue(item['mainDeviceLidoVersion'] ?? '-'),
          TextCellValue(item['mainDeviceHub'] ?? '-'),
          TextCellValue(item['mainDeviceCategory'] ?? '-'),
          TextCellValue(item['backupDeviceNo'] ?? '-'),
          TextCellValue(item['backupDeviceiOSVersion'] ?? '-'),
          TextCellValue(item['backupDeviceFlySmart'] ?? '-'),
          TextCellValue(item['backupDeviceDocuVersion'] ?? '-'),
          TextCellValue(item['backupDeviceLidoVersion'] ?? '-'),
          TextCellValue(item['backupDeviceHub'] ?? '-'),
          TextCellValue(item['backupDeviceCategory'] ?? '-'),
          TextCellValue(item['status'] ?? '-'),
          TextCellValue(item['approved_by'] ?? '-'),
          TextCellValue(item['approved_user_name'] ?? '-'),
          TextCellValue(item['approved_user_hub'] ?? '-'),
          TextCellValue(item['received_by'] ?? '-'),
          TextCellValue(item['received_user_name'] ?? '-'),
          TextCellValue(item['received_user_hub'] ?? '-'),
          TextCellValue(item['handover_to'] ?? '-'),
          TextCellValue(item['handover_user_name'] ?? '-'),
          TextCellValue(item['handover_user_rank'] ?? '-'),
          TextCellValue(item['handover_user_hub'] ?? '-'),
        ];
        sheet.appendRow(row);
      }

      final excelByte = excel.encode();
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/history_export.xlsx';
      final file = File(filePath);
      await file.writeAsBytes(excelByte!);
      await OpenFile.open(filePath);

      return true;
    } catch (e) {
      throw Exception('Error exporting to Excel: $e');
    }
  }
}
