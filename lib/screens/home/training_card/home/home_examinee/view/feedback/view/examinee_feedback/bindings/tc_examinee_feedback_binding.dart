import 'package:airmaster/screens/home/training_card/home/home_examinee/view/feedback/view/examinee_feedback/controller/tc_examinee_feedback_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: TC Examinee Feedback Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the TC Examinee Feedback feature.
  | It manages the dependencies for the examinee feedback controller.
  |--------------------------------------------------------------------------
  | created by: Meilyna Hutajulu
  | last modified by: Meilyna Hutajulu
  |
*/
class TC_ExamineeFeedback_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_ExamineeFeedback_Controller>(
      () => TC_ExamineeFeedback_Controller(),
    );
  }
}
