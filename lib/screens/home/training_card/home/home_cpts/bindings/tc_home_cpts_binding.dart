// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/home/home_cpts/controller/tc_home_cpts_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Home CPTS Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Home CPTS feature.
  | It manages the dependencies for the home CPTS controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Home_CPTS_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Home_CPTS_Controller>(() => TC_Home_CPTS_Controller());
  }
}
