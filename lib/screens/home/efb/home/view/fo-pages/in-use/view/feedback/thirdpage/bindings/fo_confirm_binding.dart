// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/thirdpage/controller/fo_confirm_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Fo Confirm Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Fo Confirm feature.
  | It manages the dependencies for the Fo Confirm Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-04
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Confirm_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Confirm_Controller>(() => Fo_Confirm_Controller());
  }
}
