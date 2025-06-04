// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/detail/view/feedback/secondpage/controller/battery_controller.dart';
import 'package:get/get.dart';

class Battery_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Battery_Controller>(() => Battery_Controller());
  }
}
