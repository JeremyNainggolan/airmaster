import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/firstpage/controller/fo_feedback_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Fo Feedback Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Fo Feedback feature.
  | It manages the dependencies for the Fo Feedback Controller.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-04
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Fo_Feedback_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Feedback_Controller>(() => Fo_Feedback_Controller());
  }
}
