import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/detail_absent/controller/tc_detail_absent_trainee_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Detail Absent Trainee Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Detail Absent Trainee feature.
  | It manages the dependencies for the absent trainee detail controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Detail_AbsentTrainee_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Detail_AbsentTrainee_Controller>(
      () => TC_Detail_AbsentTrainee_Controller(),
    );
  }
}
