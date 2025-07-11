import 'package:airmaster/screens/home/training_card/training/view/training_list/view/attendance_detail/view/attendance_participant/controller/tc_attendance_participant_controller.dart';
import 'package:get/get.dart';

class TC_AttendanceParticipant_Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TC_AttendanceParticipant_Controller>(() => TC_AttendanceParticipant_Controller());
  }
}