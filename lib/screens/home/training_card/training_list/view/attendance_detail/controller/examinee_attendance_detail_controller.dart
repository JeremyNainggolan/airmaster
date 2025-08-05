import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Examinee Attendance Detail Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Examinee Attendance Detail feature.
  | It manages the dependencies for the examinee attendance detail controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class Examinee_AttendanceDetail_Controller extends GetxController {
  dynamic data = Get.arguments;
  final attendanceData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    attendanceData.value = data['attendanceDetail'];
  }
}
