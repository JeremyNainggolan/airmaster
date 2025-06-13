import 'package:airmaster/screens/home/efb/history/view/history-detail/view/feedback/controller/detail_feedback_controller.dart';
import 'package:get/get.dart';

class Detail_Feedback_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Detail_Feedback_Controller>(() => Detail_Feedback_Controller());
  }
}
