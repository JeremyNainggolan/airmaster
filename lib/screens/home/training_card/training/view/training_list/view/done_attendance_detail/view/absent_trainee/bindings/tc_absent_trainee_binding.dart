import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_attendance_detail/view/absent_trainee/controller/tc_absent_trainee_controller.dart';
import 'package:get/get.dart';

class TC_AbsentParticipant_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_AbsentParticipant_Controller>(
      () => TC_AbsentParticipant_Controller(),
    );
  }
}
