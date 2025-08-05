import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/detail_absent/view/training_history/controller/tc_training_history_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Training History Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Training History feature.
  | It manages the dependencies for the training history controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_TrainingHistory_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_TrainingHistory_Controller>(
      () => TC_TrainingHistory_Controller(),
    );
  }
}
