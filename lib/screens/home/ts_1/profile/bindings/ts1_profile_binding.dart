// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/profile/controller/ts1_profile_controller.dart';
import 'package:get/get.dart';

class TS1_Profile_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TS1_Profile_Controller>(() => TS1_Profile_Controller());
  }
}
