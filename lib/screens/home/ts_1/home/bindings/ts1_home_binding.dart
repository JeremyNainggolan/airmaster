// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/home/controller/ts1_home_controller.dart';
import 'package:get/get.dart';

class TS1_Home_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TS1_Home_Controller>(() => TS1_Home_Controller());
  }
}
