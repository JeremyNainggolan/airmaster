import 'package:airmaster/screens/home/efb/home/view/occ-pages/return/controller/occ_returned_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: OCC Returned Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the OCC Returned feature.
  | It manages the dependencies for the OCC Returned Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-08
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class OCC_Returned_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OCC_Returned_Controller>(() => OCC_Returned_Controller());
  }
}
