// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/secondpage/controller/fo_battery_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Fo Battery Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Fo Battery feature.
  | It manages the dependencies for the Fo Battery Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-04
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Battery_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Battery_Controller>(() => Fo_Battery_Controller());
  }
}
