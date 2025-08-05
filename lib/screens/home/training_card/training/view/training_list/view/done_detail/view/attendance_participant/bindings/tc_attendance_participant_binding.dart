import 'package:airmaster/screens/home/training_card/training/view/training_list/view/confirm_detail/view/attendance_participant/controller/tc_attendance_participant_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Attendance Participant Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Attendance Participant feature.
  | It manages the dependencies for the attendance participant controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_AttendanceParticipant_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_AttendanceParticipant_Controller>(
      () => TC_AttendanceParticipant_Controller(),
    );
  }
}
