// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/training/view/new_training/controller/new_training_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: New Training Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the New Training feature.
  | It manages the dependencies for the new training controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_NewTraining_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_NewTrainingController>(() => TC_NewTrainingController());
  }
}
