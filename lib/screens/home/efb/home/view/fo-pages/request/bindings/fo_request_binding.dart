import 'package:airmaster/screens/home/efb/home/view/fo-pages/request/controller/fo_request_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Fo Request Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Fo Request feature.
  | It manages the dependencies for the Fo Request Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-06
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Request_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Request_Controller>(() => Fo_Request_Controller());
  }
}
