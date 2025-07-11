import 'package:airmaster/screens/home/training_card/training_list/view/attendance_detail/controller/examinee_attendance_detail_controller.dart';
import 'package:get/get.dart';

class Examinee_AttendanceDetail_Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<Examinee_AttendanceDetail_Controller>(() => Examinee_AttendanceDetail_Controller());
  }
}