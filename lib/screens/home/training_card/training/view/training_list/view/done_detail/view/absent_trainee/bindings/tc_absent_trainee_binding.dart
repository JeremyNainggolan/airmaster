import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/controller/tc_absent_trainee_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Absent Trainee Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Absent Trainee feature.
  | It manages the dependencies for the absent trainee controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_AbsentParticipant_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_AbsentParticipant_Controller>(
      () => TC_AbsentParticipant_Controller(),
    );
  }
}
