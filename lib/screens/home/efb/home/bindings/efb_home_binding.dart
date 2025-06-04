// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/home/controller/efb_home_controller.dart';
import 'package:get/get.dart';

class EFB_Home_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_Home_Controller>(() => EFB_Home_Controller());
  }
}
