import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Fo Used Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for handling Fo Used operations.
  | It manages the state and logic for Fo Used requests.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-04
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Used_Controller extends GetxController {
  dynamic params = Get.arguments;

  final isFeedback = false.obs;

  final device = {}.obs;

  final feedback = {}.obs;

  final handOverTo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }
}
