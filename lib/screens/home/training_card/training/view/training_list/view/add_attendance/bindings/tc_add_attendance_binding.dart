// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/training/view/training_list/view/add_attendance/controller/tc_add_attendance_controller.dart';
import 'package:get/get.dart';

class TC_AddAttendance_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_AddAttendanceController>(() => TC_AddAttendanceController());
  }
}
