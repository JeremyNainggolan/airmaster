import 'package:airmaster/screens/home/efb/home/view/occ-pages/request/controller/occ_requested_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: OCC Requested Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the OCC Requested feature.
  | It manages the dependencies for the OCC Requested Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-07
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class OCC_Requested_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OCC_Requested_Controller>(() => OCC_Requested_Controller());
  }
}
