import 'package:airmaster/screens/home/efb/home/view/fo-pages/waiting-confirmation/controller/fo_waiting_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Fo Waiting Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Fo Waiting feature.
  | It manages the dependencies for the Fo Waiting Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-07
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Waiting_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Waiting_Controller>(() => Fo_Waiting_Controller());
  }
}
