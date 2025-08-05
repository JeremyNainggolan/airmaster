// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/analytics/controller/efb_analytics_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: EFB Analytics Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the EFB Analytics Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-27
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-07-08
  |
*/
class EFB_Analytics_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_Analytics_Controller>(() => EFB_Analytics_Controller());
  }
}
