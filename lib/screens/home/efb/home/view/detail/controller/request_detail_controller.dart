// ignore_for_file: camel_case_types

import 'package:get/get.dart';

class Detail_Controller extends GetxController {
  dynamic params = Get.arguments;

  final isFeedback = false.obs;

  final feedback = {}.obs;

  final device = {}.obs;

  final handOverTo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }
}
