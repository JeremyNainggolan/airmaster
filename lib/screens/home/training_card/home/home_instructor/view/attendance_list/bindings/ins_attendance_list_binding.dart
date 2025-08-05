import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/controller/ins_attendance_list_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Instructor Attendance List Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Instructor Attendance List feature.
  | It manages the dependencies for the instructor attendance list controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Ins_AttendanceList_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Ins_AttendanceList_Controller>(
      () => TC_Ins_AttendanceList_Controller(),
    );
  }
}
