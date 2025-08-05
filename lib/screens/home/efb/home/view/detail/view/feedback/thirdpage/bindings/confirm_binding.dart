// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/thirdpage/controller/confirm_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Confirm Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Confirm Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-16
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/

class Confirm_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Confirm_Controller>(() => Confirm_Controller());
  }
}
