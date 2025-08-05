import 'package:airmaster/screens/home/training_card/training/view/training_list/view/pending_detail/controller/tc_attendance_detail_pending_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Attendance Detail Pending Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Attendance Detail Pending feature.
  | It manages the dependencies for the attendance detail pending controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_AttendanceDetail_Pending_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_AttendanceDetail_Pending_Controller>(
      () => TC_AttendanceDetail_Pending_Controller(),
    );
  }
}
