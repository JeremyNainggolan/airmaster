import 'package:airmaster/screens/home/efb/history/controller/efb_history_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: EFB History Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the EFB History Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-01
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class EFB_History_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_History_Controller>(() => EFB_History_Controller());
  }
}
