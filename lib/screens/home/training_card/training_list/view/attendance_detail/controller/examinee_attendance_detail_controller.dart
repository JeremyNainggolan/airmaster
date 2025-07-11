import 'dart:developer';

import 'package:get/get.dart';

class Examinee_AttendanceDetail_Controller extends GetxController {
  dynamic data = Get.arguments;
  final attendanceData = {}.obs;


  @override
  void onInit() {
    super.onInit();
    attendanceData.value = data['attendanceDetail'];
  }
}