// ignore_for_file: camel_case_types

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

  Future<void> loadUserData() async {
    rank.value = await UserPreferences().getRank();
    log('User rank: $rank');
  }

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
          TextCellValue(item['deviceno_2'] ?? '-'),
          TextCellValue(item['ios_version_2'] ?? '-'),
          TextCellValue(item['fly_smart_2'] ?? '-'),
          TextCellValue(item['doc_version_2'] ?? '-'),
          TextCellValue(item['lido_version_2'] ?? '-'),
          TextCellValue(item['hub_2'] ?? '-'),
          TextCellValue(item['category_2'] ?? '-'),
          TextCellValue(item['deviceno_3'] ?? '-'),
          TextCellValue(item['ios_version_3'] ?? '-'),
          TextCellValue(item['fly_smart_3'] ?? '-'),
          TextCellValue(item['doc_version_3'] ?? '-'),
          TextCellValue(item['lido_version_3'] ?? '-'),
          TextCellValue(item['hub_3'] ?? '-'),
          TextCellValue(item['category_3'] ?? '-'),
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
