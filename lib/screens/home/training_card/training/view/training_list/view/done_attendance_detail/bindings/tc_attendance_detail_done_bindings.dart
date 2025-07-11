
import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_attendance_detail/controller/tc_attendance_detail_done_controller.dart';
import 'package:get/get.dart';

class TC_AttendanceDetail_Done_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_AttendanceDetail_Done_Controller>(() => TC_AttendanceDetail_Done_Controller());
  }
}
