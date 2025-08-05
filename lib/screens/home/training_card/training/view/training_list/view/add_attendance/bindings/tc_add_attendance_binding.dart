// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/training/view/training_list/view/add_attendance/controller/tc_add_attendance_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Add Attendance Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Add Attendance feature.
  | It manages the dependencies for the add attendance controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_AddAttendance_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_AddAttendanceController>(() => TC_AddAttendanceController());
  }
}
