
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/attendance_detail/controller/tc_attendance_detail_controller.dart';
import 'package:get/get.dart';

class TC_AttendanceDetail_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_AttendanceDetail_Controller>(() => TC_AttendanceDetail_Controller());
  }
}
