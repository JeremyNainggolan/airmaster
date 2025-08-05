// ignore_for_file: camel_case_types

import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Request Detail Controller
  |--------------------------------------------------------------------------
  | This file contains the controller for the EFB Request Detail.
  | It is responsible for managing the state and logic of the request detail view.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-04-26
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Detail_Controller extends GetxController {
  /// Parameters passed to the controller, retrieved from GetX arguments.
  dynamic params = Get.arguments;

  /// Observable boolean indicating whether feedback is present.
  final isFeedback = false.obs;

  /// Observable map holding feedback data.
  final feedback = {}.obs;

  /// Observable map holding device information.
  final device = {}.obs;

  /// Observable string representing the person to whom the device is handed over.
  final handOverTo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    device.value = params['device'];
  }
}
