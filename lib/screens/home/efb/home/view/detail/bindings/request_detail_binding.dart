import 'package:airmaster/screens/home/efb/home/view/detail/controller/request_detail_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Request Detail Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Request Detail Controller.
  | It is responsible for lazy loading the controllers when they are needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-04-26
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Detail_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Detail_Controller>(() => Detail_Controller());
  }
}
