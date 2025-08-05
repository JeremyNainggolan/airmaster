import 'package:airmaster/screens/home/training_card/profile_examinee/controller/tc_profile_examinee_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Profile Examinee Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Profile Examinee feature.
  | It manages the dependencies for the examinee profile controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_ProfileExaminee_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_ProfileExaminee_Controller>(
      () => TC_ProfileExaminee_Controller(),
    );
  }
}
