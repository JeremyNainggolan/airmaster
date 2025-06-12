import 'dart:convert';
import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:airmaster/config/api_config.dart';

class TC_AddAttendanceController extends GetxController {
  // Define your variables and methods

  late GlobalKey<FormState> formKey;


  final trainingAttendanceName = TextEditingController();
  final trainingAttendanceDate = TextEditingController();
  RxString trainingAttendanceType = ''.obs;
  RxString trainingAttendanceDepartment = ''.obs;
  RxString trainingAttendanceRoom = ''.obs;
  RxString trainingAttendanceVenue =''.obs;

  RxString selectedInstructorId = ''.obs;
  final instructorController = TextEditingController();


  // ignore: non_constant_identifier_names

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
  }

  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(length, (index) => chars[(DateTime.now().millisecondsSinceEpoch + index) % chars.length]).join();
  }

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
          'idTrainingType':trainingAttendanceName.text,
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
        log('Failed to save attendance: ${jsonDecode(response.body)['message']}');
        return false;
      }
    } catch (e) {
      log('Error saving attendance: $e');
      return false;
    }
  }

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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data['data'];

        return list
            .map((json) => Instructor.fromJson(json))
            .where((instructor) =>
                instructor.name.toLowerCase().contains(pattern.toLowerCase()))
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
    return Instructor(
      id: json['id'].toString(),
      name: json['name'],
    );
  }

  @override
  String toString() => '$name ($id)';
}
