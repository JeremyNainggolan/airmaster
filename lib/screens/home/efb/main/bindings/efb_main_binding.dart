// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/analytics/controller/efb_analytics_controller.dart';
import 'package:airmaster/screens/home/efb/devices/controller/efb_device_controller.dart';
import 'package:airmaster/screens/home/efb/history/controller/efb_history_controller.dart';
import 'package:airmaster/screens/home/efb/home/controller/efb_home_controller.dart';
import 'package:airmaster/screens/home/efb/profile/controller/efb_profile_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: EFB Main Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the EFB Main Controller.
  | It is responsible for lazy loading the controllers when they are needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-04-24
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class EFB_Main_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_Home_Controller>(() => EFB_Home_Controller());
    Get.lazyPut<EFB_Device_Controller>(() => EFB_Device_Controller());
    Get.lazyPut<EFB_History_Controller>(() => EFB_History_Controller());
    Get.lazyPut<EFB_Analytics_Controller>(() => EFB_Analytics_Controller());
    Get.lazyPut<EFB_Profile_Controller>(() => EFB_Profile_Controller());
  }
}
