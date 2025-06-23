// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/view/fo-pages/in-use/view/feedback/secondpage/controller/fo_battery_controller.dart';
import 'package:get/get.dart';

class Fo_Battery_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fo_Battery_Controller>(() => Fo_Battery_Controller());
  }
}
