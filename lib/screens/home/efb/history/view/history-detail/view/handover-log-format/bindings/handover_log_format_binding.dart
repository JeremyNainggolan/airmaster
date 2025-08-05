import 'package:airmaster/screens/home/efb/history/view/history-detail/view/handover-log-format/controller/handover_log_format_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Handover Log Format Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Handover Log Format Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-01
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Handover_Log_Format_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Handover_Log_Format_Controller>(
      () => Handover_Log_Format_Controller(),
    );
  }
}
