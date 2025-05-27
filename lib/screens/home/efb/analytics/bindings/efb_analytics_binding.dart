// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/analytics/controller/efb_analytics_controller.dart';
import 'package:get/get.dart';

class EFB_Analytics_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_Analytics_Controller>(() => EFB_Analytics_Controller());
  }
}
