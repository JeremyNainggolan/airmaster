import 'package:airmaster/screens/home/efb/history/view/history-detail/view/feedback/controller/detail_feedback_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Detail Feedback Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Detail Feedback Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-01
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Detail_Feedback_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Detail_Feedback_Controller>(() => Detail_Feedback_Controller());
  }
}
