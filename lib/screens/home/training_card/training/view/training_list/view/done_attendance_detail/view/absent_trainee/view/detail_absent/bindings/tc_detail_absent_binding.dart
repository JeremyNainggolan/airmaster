import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_attendance_detail/view/absent_trainee/view/detail_absent/controller/tc_detail_absent_trainee_controller.dart';
import 'package:get/get.dart';

class TC_Detail_AbsentTrainee_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Detail_AbsentTrainee_Controller>(() => TC_Detail_AbsentTrainee_Controller());
  }
}