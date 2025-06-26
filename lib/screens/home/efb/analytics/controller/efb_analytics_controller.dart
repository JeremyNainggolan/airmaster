// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EFB_Analytics_Controller extends GetxController {
  final fromDateText = ''.obs;
  final toDateText = ''.obs;

  final fromDate = TextEditingController(
    text: DateFormatter.convertDateTimeDisplay(
      DateFormatter.getStartOfYear().toString(),
      'dd MMMM yyyy',
    ),
  );
  final toDate = TextEditingController(
    text: DateFormatter.convertDateTimeDisplay(
      DateFormatter.getCurrentDateWithoutTime().toString(),
      'dd MMMM yyyy',
    ),
  );

  final RxList<dynamic> data = <dynamic>[].obs;
  final RxList<dynamic> filteredData = <dynamic>[].obs;

  final RxList<String> hubList = <String>[].obs;
  late List<Map<String, String>> legendList = [];
  late List<Map<String, Map<String, dynamic>>> legendListCount = [];

  final RxString selectedHub = ''.obs;

  final isLoading = false.obs;

  final acknowledgeCountText = TextEditingController();
  final returnCountText = TextEditingController();

  final firstDeviceAcknowledgeText = TextEditingController();
  final otherDeviceAcknowledgeText = TextEditingController();

  final firstDeviceReturnText = TextEditingController();
  final otherDeviceReturnText = TextEditingController();

  final unfinishedProcessCountText = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    fromDateText.value = fromDate.text;
    toDateText.value = toDate.text;
    await getAllPilotDevices();
    await getHub();
    await setLegendData();
    await setAnalyticsData();
  }

  Future<void> refreshData() async {
    fromDateText.value = fromDate.text;
    toDateText.value = toDate.text;
    hubList.clear();
    legendList.clear();
    legendListCount.clear();
    await getAllPilotDevices();
    await getHub();
    await setLegendData();
    await setAnalyticsData();
  }

  Future<void> getAllPilotDevices() async {
    isLoading.value = true;
    try {
      String token = await UserPreferences().getToken();

      final response = await http.get(
        Uri.parse(ApiConfig.get_all_pilot_devices),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        data.clear();
        filteredData.clear();
        data.assignAll(responseData['data']);
        filteredData.assignAll(data);
      }
    } catch (e) {
      log('Error fetching pilot devices: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> filterData() async {
    isLoading.value = true;
    try {
      List<dynamic> tempFilteredData = List.from(data);

      // --- Date Filtering ---
      if (fromDateText.value.isNotEmpty && toDateText.value.isNotEmpty) {
        try {
          final DateTime from = DateFormatter.convertToDate(
            fromDateText.value,
            'dd MMMM yyyy',
          );
          final DateTime to = DateFormatter.convertToDate(
            toDateText.value,
            'dd MMMM yyyy',
          );

          tempFilteredData =
              tempFilteredData.where((item) {
                final DateTime itemDate = DateFormatter.convertToDate(
                  item['request_date'],
                  'yyyy-MM-dd',
                );
                return itemDate.isAfter(from) && itemDate.isBefore(to);
              }).toList();
          log('Date filtered successfully: ${tempFilteredData.length} items');
        } catch (e) {
          log('Error parsing dates for filtering: $e');
        }
      }

      // --- Hub Filtering ---
      if (selectedHub.value.isNotEmpty) {
        final String currentSelectedHub = selectedHub.value;
        if (currentSelectedHub != '') {
          tempFilteredData =
              tempFilteredData.where((item) {
                if (item['hub'] == currentSelectedHub) {
                  return true;
                }
                if (item['isFoRequest'] == true) {
                  if (item['mainDeviceHub'] == currentSelectedHub ||
                      item['backupDeviceHub'] == currentSelectedHub) {
                    return true;
                  }
                }
                return false;
              }).toList();
          log('Hub filtered successfully: ${tempFilteredData.length} items');
        }
      }

      filteredData.assignAll(tempFilteredData);
      setAnalyticsData();
      log('Combined filter complete: ${filteredData.length} items');
    } catch (e) {
      log('Error during data filtering: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setAnalyticsData() async {
    isLoading.value = true;
    try {
      acknowledgeCountText.text = await countForAcknowledge().then((value) {
        if (value > 1) {
          return '${value.toString()} Devices';
        } else {
          return '${value.toString()} Device';
        }
      });
      returnCountText.text = await countForReturn().then((value) {
        if (value > 1) {
          return '${value.toString()} Devices';
        } else {
          return '${value.toString()} Device';
        }
      });

      firstDeviceAcknowledgeText
          .text = await countForFirstDeviceAcknowledge().then((value) async {
        if (value > 0) {
          var temp = await countAllDevices();
          var percent = (value / temp * 100);
          if (value > 1) {
            return '${percent.toStringAsFixed(2)}% (${value.toString()} Devices)';
          } else {
            return '${percent.toStringAsFixed(2)}% (${value.toString()} Device)';
          }
        } else {
          return '0% (0)';
        }
      });

      otherDeviceAcknowledgeText
          .text = await countForOtherDeviceAcknowledge().then((value) async {
        if (value > 0) {
          var temp = await countAllDevices();
          var percent = (value / temp * 100);
          if (value > 1) {
            return '${percent.toStringAsFixed(2)}% (${value.toString()} Devices)';
          } else {
            return '${percent.toStringAsFixed(2)}% (${value.toString()} Device)';
          }
        } else {
          return '0% (0)';
        }
      });

      firstDeviceReturnText.text = await countForFirstDeviceReturn().then((
        value,
      ) async {
        if (value > 0) {
          var temp = await countAllDevices();
          var percent = (value / temp * 100);
          if (value > 1) {
            return '${percent.toStringAsFixed(2)}% (${value.toString()} Devices)';
          } else {
            return '${percent.toStringAsFixed(2)}% (${value.toString()} Device)';
          }
        } else {
          return '0% (0)';
        }
      });

      otherDeviceReturnText.text = await countForOtherDeviceReturn().then((
        value,
      ) async {
        if (value > 0) {
          var temp = await countAllDevices();
          var percent = (value / temp * 100);
          if (value > 1) {
            return '${percent.toStringAsFixed(2)}% (${value.toString()} Devices)';
          } else {
            return '${percent.toStringAsFixed(2)}% (${value.toString()} Device)';
          }
        } else {
          return '0% (0)';
        }
      });

      unfinishedProcessCountText.text = await countForUnfinishedProcess().then((
        value,
      ) {
        if (value > 1) {
          return '${value.toString()} Devices';
        } else {
          return '${value.toString()} Device';
        }
      });
    } catch (e) {
      log('Error setting analytics data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<int> countAllDevices() async {
    int tempCount = 0;
    try {
      for (var item in filteredData) {
        if (item['isFoRequest'] == true) {
          tempCount += 2;
        } else {
          tempCount += 1;
        }
      }
    } catch (e) {
      log('Error counting devices: $e');
    }
    return tempCount;
  }

  Future<int> countForUnfinishedProcess() async {
    int tempCount = 0;
    try {
      for (var item in filteredData) {
        if (item['status'] == 'used' ||
            item['status'] == 'waiting' ||
            item['status'] == 'handover_confirmation') {
          if (item['isFoRequest'] == true) {
            tempCount += 2;
          } else {
            tempCount += 1;
          }
        }
      }
    } catch (e) {
      log('Error counting unfinished processes: $e');
    }
    return tempCount;
  }

  Future<int> countForAcknowledge() async {
    int tempCount = 0;
    try {
      for (var item in filteredData) {
        if (item['status'] == 'used' ||
            item['status'] == 'waiting' ||
            item['status'] == 'handover_confirmation') {
          if (item['isFoRequest'] == true) {
            tempCount += 2;
          } else {
            tempCount += 1;
          }
        }
      }
    } catch (e) {
      log('Error counting devices: $e');
    }
    return tempCount;
  }

  Future<int> countForFirstDeviceAcknowledge() async {
    int tempCount = 0;
    try {
      for (var item in filteredData) {
        if (item['status'] == 'used' ||
            item['status'] == 'waiting' ||
            item['status'] == 'handover_confirmation') {
          if (item['isFoRequest'] == true) {
            continue;
          } else {
            tempCount += 1;
          }
        }
      }
    } catch (e) {
      log('Error counting first device acknowledge: $e');
    }
    return tempCount;
  }

  Future<int> countForOtherDeviceAcknowledge() async {
    int tempCount = 0;
    try {
      for (var item in filteredData) {
        if (item['status'] == 'used' ||
            item['status'] == 'waiting' ||
            item['status'] == 'handover_confirmation') {
          if (item['isFoRequest'] == true) {
            tempCount += 2;
          }
        }
      }
    } catch (e) {
      log('Error counting other device acknowledge: $e');
    }
    return tempCount;
  }

  Future<int> countForReturn() async {
    int tempCount = 0;
    try {
      for (var item in filteredData) {
        if (item['status'] == 'handover' || item['status'] == 'returned') {
          if (item['isFoRequest'] == true) {
            tempCount += 2;
          } else {
            tempCount += 1;
          }
        }
      }
    } catch (e) {
      log('Error counting devices for return: $e');
    }
    return tempCount;
  }

  Future<int> countForFirstDeviceReturn() async {
    int tempCount = 0;
    try {
      for (var item in filteredData) {
        if (item['status'] == 'handover' || item['status'] == 'returned') {
          if (item['isFoRequest'] == true) {
            continue;
          } else {
            tempCount += 1;
          }
        }
      }
    } catch (e) {
      log('Error counting first device return: $e');
    }
    return tempCount;
  }

  Future<int> countForOtherDeviceReturn() async {
    int tempCount = 0;
    try {
      for (var item in filteredData) {
        if (item['status'] == 'handover' || item['status'] == 'returned') {
          if (item['isFoRequest'] == true) {
            tempCount += 2;
          }
        }
      }
    } catch (e) {
      log('Error counting other device return: $e');
    }
    return tempCount;
  }

  Future<void> selectFromDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateFormatter.getStartOfYear(),
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
      fromDateText.value = fromDate.text;
      filterData();
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
      toDateText.value = toDate.text;
      filterData();
    } else {
      toDate.clear();
    }
  }

  Future<void> getHub() async {
    isLoading.value = true;
    try {
      String token = await UserPreferences().getToken();

      final response = await http.get(
        Uri.parse(ApiConfig.get_hub),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        hubList.clear();
        if (data['data'] != null && data['data'].isNotEmpty) {
          for (var hub in data['data']) {
            hubList.add(hub.toString());
          }
        }
      }
    } catch (e) {
      log('Error fetching hub list: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setLegendData() async {
    var pastelColors = RandomColor.getColor(
      Options(
        luminosity: Luminosity.light,
        format: Format.hex,
        count: hubList.length,
      ),
    );
    for (var i = 0; i < hubList.length; i++) {
      await getPieChartData(hubList[i], pastelColors[i]);
      legendList.add({hubList[i]: pastelColors[i]});
    }
  }

  Future<void> getPieChartData(String hub, String color) async {
    isLoading.value = true;
    try {
      String token = await UserPreferences().getToken();

      final response = await http.get(
        Uri.parse(
          ApiConfig.get_count_hub,
        ).replace(queryParameters: {'hub': hub}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = responseData['data'];
        legendListCount.add({
          hub: {'total': data, 'color': color},
        });
      }
    } catch (e) {
      log('Error fetching count for hub $hub: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
