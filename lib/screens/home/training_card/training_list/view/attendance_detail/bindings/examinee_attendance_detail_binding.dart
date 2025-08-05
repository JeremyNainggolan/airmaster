import 'package:airmaster/screens/home/training_card/training_list/view/attendance_detail/controller/examinee_attendance_detail_controller.dart';
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
class Examinee_AttendanceDetail_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Examinee_AttendanceDetail_Controller>(
      () => Examinee_AttendanceDetail_Controller(),
    );
  }
}
