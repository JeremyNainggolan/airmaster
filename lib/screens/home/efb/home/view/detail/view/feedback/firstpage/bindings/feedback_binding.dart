// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/firstpage/controller/feedback_controller.dart';
import 'package:get/get.dart';

class Feedback_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Feedback_Controller>(() => Feedback_Controller());
  }
}
