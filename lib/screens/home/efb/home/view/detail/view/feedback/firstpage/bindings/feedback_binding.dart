// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/firstpage/controller/feedback_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Feedback Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Feedback Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-12
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Feedback_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Feedback_Controller>(() => Feedback_Controller());
  }
}
