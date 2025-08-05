import 'package:airmaster/screens/home/efb/home/view/detail/view/return-occ/controller/occ_return_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: OCC Return Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the OCC Return feature.
  | It manages the dependencies for the OCC Return controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-05-21
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Occ_Return_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Occ_Return_Controller>(() => Occ_Return_Controller());
  }
}
