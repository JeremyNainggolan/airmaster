import 'dart:developer';
import 'dart:convert';

import 'package:airmaster/config/api_config.dart';
import 'package:airmaster/data/users/user_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TC_AttendanceDetail_Controller extends GetxController
{
  final attendanceData = Get.arguments;

  final attendanceParticipant = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}
