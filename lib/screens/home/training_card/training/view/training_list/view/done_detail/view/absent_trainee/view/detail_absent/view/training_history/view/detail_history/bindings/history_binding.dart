import 'package:airmaster/screens/home/training_card/training/view/training_list/view/done_detail/view/absent_trainee/view/detail_absent/view/training_history/view/detail_history/controller/history_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Detail Training History Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Detail Training History feature.
  | It manages the dependencies for the training history detail controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Detail_TrainingHistory_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Detail_TrainingHistory_Controller>(
      () => TC_Detail_TrainingHistory_Controller(),
    );
  }
}
