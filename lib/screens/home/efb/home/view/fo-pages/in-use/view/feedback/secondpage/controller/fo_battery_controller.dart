// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
