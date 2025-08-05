import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/controller/tc_attendance_detail_done_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Attendance Detail Done Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Attendance Detail Done feature.
  | It manages the dependencies for the attendance detail done controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_AttendanceDetail_Done_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_AttendanceDetail_Done_Controller>(
      () => TC_AttendanceDetail_Done_Controller(),
    );
  }
}
