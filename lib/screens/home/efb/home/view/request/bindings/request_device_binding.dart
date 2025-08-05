// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/request/controller/request_device_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Request Device Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Request Device feature.
  | It manages the dependencies for the Request Device Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-02
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Request_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Request_Controller>(() => Request_Controller());
  }
}
