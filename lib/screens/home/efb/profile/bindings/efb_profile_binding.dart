// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/profile/controller/efb_profile_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: EFB Profile Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the EFB Profile Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-04-24
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class EFB_Profile_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_Profile_Controller>(() => EFB_Profile_Controller());
  }
}
