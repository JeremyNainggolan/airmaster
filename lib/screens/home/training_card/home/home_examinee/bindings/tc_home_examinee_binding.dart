// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/home/home_examinee/controller/tc_home_examinee_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Home Examinee Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Home Examinee feature.
  | It manages the dependencies for the home examinee controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Home_Examinee_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Home_Examinee_Controller>(
      () => TC_Home_Examinee_Controller(),
    );
  }
}
