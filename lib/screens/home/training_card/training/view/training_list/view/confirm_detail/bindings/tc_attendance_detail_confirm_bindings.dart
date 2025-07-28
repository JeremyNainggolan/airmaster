
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/confirm_detail/controller/tc_attendance_detail_confirm_controller.dart';
import 'package:get/get.dart';

class TC_AttendanceDetail_Confirm_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_AttendanceDetail_Confirm_Controller>(() => TC_AttendanceDetail_Confirm_Controller());
  }
}
