// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/profile/controller/efb_profile_controller.dart';
import 'package:get/get.dart';

class EFB_Profile_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_Profile_Controller>(() => EFB_Profile_Controller());
  }
}
