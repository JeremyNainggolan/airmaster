// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Confirm_Controller extends GetxController {
  final params = Get.arguments;

  final device = {}.obs;
  final feedbackQuestion = {}.obs;
  final batteryQuestion = {}.obs;

  final q13 = ''.obs;
  final q14 = ''.obs;
  final q15 = ''.obs;
  final q16 = ''.obs;
  final q17 = ''.obs;
  final q18 = ''.obs;
  final q19 = TextEditingController();
  final q20 = ''.obs;
  final q21 = ''.obs;
  final q22 = ''.obs;
  final q23 = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
    feedbackQuestion.value = params['feedback_question'];
    batteryQuestion.value = params['battery_question'];
  }
}
