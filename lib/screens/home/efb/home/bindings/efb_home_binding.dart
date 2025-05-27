// ignore_for_file: camel_case_types

import 'package:get/get.dart';

class EFB_Home_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_Home_Binding>(() => EFB_Home_Binding());
  }
}
