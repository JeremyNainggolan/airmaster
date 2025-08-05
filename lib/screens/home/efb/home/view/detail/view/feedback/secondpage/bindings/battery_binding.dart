// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/secondpage/controller/battery_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Battery Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Battery Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-14
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Battery_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Battery_Controller>(() => Battery_Controller());
  }
}
