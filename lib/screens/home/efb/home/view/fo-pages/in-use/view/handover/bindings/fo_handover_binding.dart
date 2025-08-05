import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/handover/controller/fo_handover_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Fo Handover Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Fo Handover feature.
  | It manages the dependencies for the Fo Handover Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-04
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Handover_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Handover_Controller>(() => Fo_Handover_Controller());
  }
}
