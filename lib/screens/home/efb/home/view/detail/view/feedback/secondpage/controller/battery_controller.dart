// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Battery Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the Battery feature.
  | It is responsible for managing the state and logic of the battery feedback form.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-14
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Battery_Controller extends GetxController {
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
