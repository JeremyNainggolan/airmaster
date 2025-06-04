// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/thirdpage/controller/confirm_controller.dart';
import 'package:get/get.dart';

class Confirm_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Confirm_Controller>(() => Confirm_Controller());
  }
}
