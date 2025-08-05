import 'package:airmaster/screens/home/efb/home/view/accept-handover/controller/accept_handover_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Accept Handover Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Accept Handover Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-01
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Accept_Handover_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Accept_Handover_Controller>(() => Accept_Handover_Controller());
  }
}
