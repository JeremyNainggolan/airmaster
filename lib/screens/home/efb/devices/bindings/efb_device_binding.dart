// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/devices/controller/efb_device_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: EFB Device Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the EFB Device Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-27
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-07-08
  |
*/
class EFB_Device_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_Device_Controller>(() => EFB_Device_Controller());
  }
}
