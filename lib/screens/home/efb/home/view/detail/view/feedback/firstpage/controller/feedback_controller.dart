// ignore_for_file: camel_case_types

import 'package:get/get.dart';

class Feedback_Controller extends GetxController {
  final params = Get.arguments;

  final device = {}.obs;

  final q1 = ''.obs;
  final q2 = ''.obs;
  final q3 = ''.obs;
  final q4 = ''.obs;
  final q5 = ''.obs;
  final q6 = ''.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }
}
