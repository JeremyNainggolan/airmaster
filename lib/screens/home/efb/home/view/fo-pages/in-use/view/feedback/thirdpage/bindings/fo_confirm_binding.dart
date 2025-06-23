// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/thirdpage/controller/fo_confirm_controller.dart';
import 'package:get/get.dart';

class Fo_Confirm_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Confirm_Controller>(() => Fo_Confirm_Controller());
  }
}
