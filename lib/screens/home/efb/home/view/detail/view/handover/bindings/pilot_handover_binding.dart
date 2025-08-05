import 'package:airmaster/screens/home/efb/home/view/detail/view/handover/controller/pilot_handover_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Pilot Handover Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Pilot Handover Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-20
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Pilot_Handover_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Pilot_Handover_Controller>(() => Pilot_Handover_Controller());
  }
}
