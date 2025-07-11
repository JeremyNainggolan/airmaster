import 'package:airmaster/screens/home/training_card/home/home_instructor/view/attendance_list/controller/ins_attendance_list_controller.dart';
import 'package:get/get.dart';

class TC_Ins_AttendanceList_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Ins_AttendanceList_Controller>(() => TC_Ins_AttendanceList_Controller());
  }
}
