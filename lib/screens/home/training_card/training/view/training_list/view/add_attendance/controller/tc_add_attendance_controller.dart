// ignore: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:airmaster/config/api_config.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Add Attendance Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for adding attendance in the training module.
  | It manages the state and logic for creating new attendance records.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_AddAttendanceController extends GetxController {
  late GlobalKey<FormState> formKey;

  final trainingAttendanceName = TextEditingController();
  final trainingAttendanceDate = TextEditingController();
  RxString trainingAttendanceType = ''.obs;
  RxString trainingAttendanceDepartment = ''.obs;
  RxString trainingAttendanceRoom = ''.obs;
  RxString trainingAttendanceVenue = ''.obs;

  RxString selectedInstructorId = ''.obs;
  final instructorController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
  }

  /// Generates a random string of the specified [length] using
  /// uppercase and lowercase English letters.
  ///
  /// Note: The randomness is based on the current time in milliseconds
  /// and the index, which may not provide strong randomness for security purposes.
  ///
  /// [length] The length of the string to generate.
  ///
  /// Returns a randomly generated string.
  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(
      length,
      (index) =>
          chars[(DateTime.now().millisecondsSinceEpoch + index) % chars.length],
    ).join();
  }

  /// Saves the attendance record by sending a POST request to the server.
  ///
  /// The attendance details are collected from various controllers and sent as
  /// the request body. The request includes an authorization token in the headers.
  ///
  /// Returns `true` if the attendance was saved successfully (HTTP 200),
  /// otherwise returns `false`. In case of an exception, logs the error and returns `false`.
  ///
  /// Throws no exceptions.
  Future<bool?> saveAttendance() async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.new_training_attendance),
        body: {
          'subject': trainingAttendanceName.text,
          'date': trainingAttendanceDate.text,
          'department': trainingAttendanceDepartment.value,
          'room': trainingAttendanceRoom.value,
          'venue': trainingAttendanceVenue.value,
          'keyAttendance': _generateRandomString(6),
          'idTrainingType': trainingAttendanceName.text,
          'instructor': selectedInstructorId.value,
          'trainingType': trainingAttendanceType.value,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        log('Attendance saved successfully');
        return true;
      } else {
        log(
          'Failed to save attendance: ${jsonDecode(response.body)['message']}',
        );
        return false;
      }
    } catch (e) {
      log('Error saving attendance: $e');
      return false;
    }
  }

  /// Fetches a list of instructor suggestions based on the provided [pattern].
  ///
  /// Makes an HTTP GET request to retrieve instructor data, then filters the results
  /// to include only instructors whose names contain the [pattern] (case-insensitive).
  ///
  /// Returns a [Future] that completes with a list of [Instructor] objects matching the pattern.
  /// If the request fails or an error occurs, returns an empty list.
  ///
  /// Logs the response body and any errors encountered during the fetch process.
  ///
  /// [pattern] The search string used to filter instructor names.
  ///
  /// Throws no exceptions; errors are logged and an empty list is returned on failure.
  Future<List<Instructor>> getInstructorSuggestions(String pattern) async {
    String token = await UserPreferences().getToken();
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.get_att_instructor),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data['data'];

        return list
            .map((json) => Instructor.fromJson(json))
            .where(
              (instructor) =>
                  instructor.name.toLowerCase().contains(pattern.toLowerCase()),
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
}

class Instructor {
  final String id;
  final String name;

  Instructor({required this.id, required this.name});

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(id: json['id'].toString(), name: json['name']);
  }

  @override
  String toString() => '$name ($id)';
}
