import 'package:airmaster/screens/home/training_card/training_list/view/create_attendance/controller/examine_create_attendance_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Examinee Create Attendance Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Examinee Create Attendance feature.
  | It manages the dependencies for the examinee create attendance controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class Examinee_CreateAttendance_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Examinee_CreateAttendance_Controller>(
      () => Examinee_CreateAttendance_Controller(),
    );
  }
}
