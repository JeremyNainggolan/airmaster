// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/home/home_administrator/controller/tc_home_administrator_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Home Administrator Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Home Administrator feature.
  | It manages the dependencies for the home administrator controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Home_Administrator_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Home_Administrator_Controller>(
      () => TC_Home_Administrator_Controller(),
    );
  }
}
