import 'package:airmaster/screens/home/training_card/training_list/view/create_attendance/controller/examine_create_attendance_controller.dart';
import 'package:get/get.dart';

class Examinee_CreateAttendance_Binding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut<Examinee_CreateAttendance_Controller>(() => Examinee_CreateAttendance_Controller());
  }
}