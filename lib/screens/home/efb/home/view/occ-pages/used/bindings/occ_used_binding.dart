import 'package:airmaster/screens/home/efb/home/view/occ-pages/used/controller/occ_used_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: OCC Used Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the OCC Used feature.
  | It manages the dependencies for the OCC Used Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-08
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class OCC_Used_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OCC_Used_Controller>(() => OCC_Used_Controller());
  }
}
