import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Pilot_Handover_Controller extends GetxController {
  dynamic params = Get.arguments;

  final device = {}.obs;
  final feedback = {}.obs;

  final remark = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
    if (params['feedback'] != null) {
      feedback.value = params['feedback'];
    }
  }
}
