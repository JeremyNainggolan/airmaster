import 'package:airmaster/screens/home/training_card/training/view/training_list/controller/training_list_detail_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Training List Detail Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Training List Detail feature.
  | It manages the dependencies for the training list detail controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_TrainingListDetail_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_TrainingListDetail_Controller>(
      () => TC_TrainingListDetail_Controller(),
    );
  }
}
