import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/controller/fo_used_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Fo Used Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Fo Used feature.
  | It manages the dependencies for the Fo Used Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-04
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Used_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Used_Controller>(() => Fo_Used_Controller());
  }
}
