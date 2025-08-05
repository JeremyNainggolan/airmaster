import 'package:airmaster/screens/home/efb/history/view/history-detail/controller/history_detail_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: EFB History Detail Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the EFB History Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-28
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class History_Detail_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<History_Detail_Controller>(() => History_Detail_Controller());
  }
}
