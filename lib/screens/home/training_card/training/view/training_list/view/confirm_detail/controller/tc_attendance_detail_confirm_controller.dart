import 'dart:developer';
import 'dart:convert';
import 'dart:typed_data';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Attendance Detail Confirm Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for confirming attendance details in the
  | training card feature of the application.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_AttendanceDetail_Confirm_Controller extends GetxController {
  final isLoading = false.obs;
  final selectedOption = "".obs;
  final attendanceData = Get.arguments;
  final attendanceParticipant = [].obs;
  final remarksController = TextEditingController();
  final traineesController = TextEditingController();

  RxString selectedTraineeId = ''.obs;
  final listSelectedTrainees = <Trainee>[].obs;
  final instructorList = <Trainee>[].obs;

  final signatureKey = GlobalKey<SfSignaturePadState>();
  Uint8List? signatureImg;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    selectedOption.value = attendanceData['attendanceType'];
    await totalParticipant();
    fetchInstructorList();
    isLoading.value = false;
  }

  /// Fetches the list of instructor suggestions asynchronously and updates the [instructorList].
  ///
  /// This method retrieves instructor suggestions by calling [getInstructorSuggestions] with an empty
  /// query string, and then assigns the resulting list to [instructorList].
  ///
  /// Typically used to initialize or refresh the instructor list in the UI.
  Future<void> fetchInstructorList() async {
    final result = await getInstructorSuggestions('');
    instructorList.assignAll(result);
  }

  /// Fetches the total number of participants for a specific attendance record.
  ///
  /// This asynchronous method retrieves the authentication token, sends a GET request
  /// to the API endpoint to obtain participant data for the given attendance ID, and
  /// updates the `attendanceParticipant` list with the received data. It returns the
  /// total number of participants if the request is successful, or `0` if there is
  /// an error or the request fails.
  ///
  /// Returns:
  ///   - `int`: The total number of participants, or `0` on failure.
  ///
  /// Logs:
  ///   - The response body from the API.
  ///   - The total number of participants on success.
  ///   - Error messages on failure.
  Future<int> totalParticipant() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.get_total_participant_confirm,
        ).replace(queryParameters: {'_id': attendanceData['_id']}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        attendanceParticipant.assignAll(data['data']);
        log('Total participants: ${attendanceParticipant.length.toString()}');
        return attendanceParticipant.length;
      } else {
        log('Failed to load participants: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      log('Error fetching participants: $e');
      return 0;
    }
  }

  /// Fetches a list of instructor suggestions based on the provided [pattern].
  ///
  /// Makes an HTTP GET request to retrieve a list of pilots, then filters the results
  /// to include only those whose names contain the [pattern] (case-insensitive).
  ///
  /// Returns a [Future] that resolves to a [List] of [Trainee] objects matching the pattern.
  /// If the request fails or an error occurs, returns an empty list.
  ///
  /// Throws no exceptions; errors are logged internally.
  Future<List<Trainee>> getInstructorSuggestions(String pattern) async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_pilot_list),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data['data'];

        return list
            .map((json) => Trainee.fromJson(json))
            .where(
              (trainee) =>
                  trainee.name.toLowerCase().contains(pattern.toLowerCase()),
            )
            .toList();
      } else {
        log("Failed to fetch instructors: ${response.body}");
        return [];
      }
    } catch (e) {
      log('Error fetching instructors: $e');
      return [];
    }
  }

  /// Fetches the valid until date for the current training attendance.
  ///
  /// This method retrieves the authentication token from user preferences,
  /// then sends a GET request to the recurrent date training API endpoint
  /// with the subject ID as a query parameter. If the request is successful
  /// (HTTP 200), it returns the 'data' field from the response, which
  /// represents the valid until date. If the request fails or an exception
  /// occurs, it returns an empty string.
  ///
  /// Returns a [Future<String>] containing the valid until date or an empty string on failure.
  Future<String> validUntil() async {
    String token = await UserPreferences().getToken();

    try {
      final response = await http.get(
        Uri.parse(
          ApiConfig.recurrent_date_training,
        ).replace(queryParameters: {'id': '${attendanceData['subject']}'}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final recurrent = jsonDecode(response.body);
      log('recurrent 1: ${recurrent['data']}');

      if (response.statusCode == 200) {
        return recurrent['data'];
      }
      return '';
    } catch (e) {
      log('Error : $e');
      return '';
    }
  }

  /// Confirms the attendance for a class by sending a multipart HTTP request to the server.
  ///
  /// This method performs the following steps:
  /// - Retrieves the authentication token and administrator ID from user preferences.
  /// - Logs the IDs of absent trainees.
  /// - Determines the validity period (`valid_to`) for the attendance based on the recurrence type.
  /// - Prepares a multipart request including:
  ///   - Authorization and content headers.
  ///   - Administrator ID, validity date, absent trainees, and signature image.
  /// - Sends the request to the server and logs the response.
  /// - Returns `true` if the attendance confirmation is successful (`statusCode == 200`), otherwise returns `false`.
  ///
  /// Returns a [Future] that completes with a [bool] indicating success or failure.
  ///
  /// Throws an exception if an error occurs during the process.
  Future<bool> confirmClassAttendance() async {
    String token = await UserPreferences().getToken();

    log(
      'Absent Trainees: ${listSelectedTrainees.map((e) => e.id).toList().join(',')}',
    );

    DateTime nextMonths;
    var recurrent = await validUntil();
    log('Recurrent 2: $recurrent');
    DateTime dates = DateTime.parse(attendanceData['date']);

    nextMonths = DateTime(dates.year, dates.month, dates.day);
    log('Recurrent 3: $recurrent');

    if (recurrent == "NONE") {
      nextMonths = DateTime(dates.year, dates.month, dates.day);
    } else if (recurrent == "6 MONTH CALENDER") {
      nextMonths = DateTime(dates.year, dates.month + 6, dates.day);
    } else if (recurrent == "12 MONTH CALENDER") {
      nextMonths = DateTime(dates.year, dates.month + 12, dates.day);
    } else if (recurrent == "24 MONTH CALENDER") {
      nextMonths = DateTime(dates.year, dates.month + 24, dates.day);
    } else if (recurrent == "36 MONTH CALENDER") {
      nextMonths = DateTime(dates.year, dates.month + 36, dates.day);
    } else if (recurrent ==
        "LAST MONTH ON THE NEXT YEAR OF THE PREVIOUS TRAINING") {
      nextMonths = DateTime(dates.year + 1, 12, 31);
    }

    try {
      final request = http.MultipartRequest(
        'post',
        Uri.parse(
          ApiConfig.confirm_class_attendance,
        ).replace(queryParameters: {'_id': '${attendanceData['_id']}'}),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['idPilotAdministrator'] =
          await UserPreferences().getIdNumber();
      request.fields['valid_to'] = nextMonths.toIso8601String();
      request.fields['absentTrainees'] = listSelectedTrainees
          .map((e) => e.id)
          .toList()
          .join(',');

      request.files.add(
        http.MultipartFile.fromBytes(
          'signature',
          signatureImg!,
          filename: 'signature_${attendanceData['_id']}.png',
          contentType: MediaType('image', 'png'),
        ),
      );

      final response = await request.send();

      log('Response body: ${await response.stream.bytesToString()}');
      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        return true;
      } else {
        log('Failed to create attendance: ${response.statusCode}');
        log('Response body: ${await response.stream.bytesToString()}');
        await Future.delayed(const Duration(seconds: 2));
        return false;
      }
    } catch (e) {
      log('Error creating attendance: $e');
      await Future.delayed(const Duration(seconds: 2));

      return false;
    }
  }
}

class Trainee {
  final String id;
  final String name;

  Trainee({required this.id, required this.name});

  factory Trainee.fromJson(Map<String, dynamic> json) {
    return Trainee(
      id: json['id_number']?.toString() ?? '',
      name: json['name'] ?? '',
    );
  }

  @override
  String toString() => '$name ($id)';
}
