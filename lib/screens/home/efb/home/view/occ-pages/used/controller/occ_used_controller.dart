import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: OCC Used Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling OCC Used operations.
  | It manages the state and logic for OCC Used requests.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-08
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class OCC_Used_Controller extends GetxController {
  dynamic params = Get.arguments;

  final device = {}.obs;
  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }
}
