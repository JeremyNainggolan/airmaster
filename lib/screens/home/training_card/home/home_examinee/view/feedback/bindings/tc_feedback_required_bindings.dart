import 'package:airmaster/screens/home/training_card/home/home_examinee/view/feedback/controller/tc_feedback_required_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Feedback Required Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Feedback Required feature.
  | It manages the dependencies for the feedback required controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_FeedbackRequired_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_FeedbackRequired_Controller>(
      () => TC_FeedbackRequired_Controller(),
    );
  }
}
