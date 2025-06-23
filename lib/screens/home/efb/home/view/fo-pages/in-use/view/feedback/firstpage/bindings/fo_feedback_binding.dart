import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/firstpage/controller/fo_feedback_controller.dart';
import 'package:get/get.dart';

class Fo_Feedback_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Feedback_Controller>(() => Fo_Feedback_Controller());
  }
}
