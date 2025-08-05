// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/profile/controller/tc_profile_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Profile Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Profile feature.
  | It manages the dependencies for the profile controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_Profile_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Profile_Controller>(() => TC_Profile_Controller());
  }
}
