import 'package:airmaster/screens/home/training_card/home/home_examinee/view/feedback/controller/tc_feedback_required_controller.dart';
import 'package:get/get.dart';

class TC_FeedbackRequired_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_FeedbackRequired_Controller>(() => TC_FeedbackRequired_Controller());
  }
}
