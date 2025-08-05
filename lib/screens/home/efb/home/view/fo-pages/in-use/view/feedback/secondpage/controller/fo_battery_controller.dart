// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Fo Battery Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling Fo Battery operations.
  | It manages the state and logic for Fo Battery feedback requests.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-04
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Battery_Controller extends GetxController {
  dynamic params = Get.arguments;

  final feedbackQuestion = {}.obs;

  final q7 = TextEditingController();
  final q8 = TextEditingController();
  final q9 = TextEditingController();
  final q10 = TextEditingController();
  final q11 = TextEditingController();
  final q12 = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    feedbackQuestion.value = params['feedback_question'];
  }
}
