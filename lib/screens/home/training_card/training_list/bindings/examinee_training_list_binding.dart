// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/training_list/controller/examainee_training_list_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Examinee Training List Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Examinee Training List feature.
  | It manages the dependencies for the examinee training list controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_TrainingList_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_TrainingList_Controller>(() => TC_TrainingList_Controller());
  }
}
