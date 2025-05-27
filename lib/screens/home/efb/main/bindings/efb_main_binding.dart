// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/efb/analytics/controller/efb_analytics_controller.dart';
import 'package:airmaster/screens/home/efb/devices/controller/efb_device_controller.dart';
import 'package:airmaster/screens/home/efb/history/controller/efb_history_controller.dart';
import 'package:airmaster/screens/home/efb/home/controller/efb_home_controller.dart';
import 'package:airmaster/screens/home/efb/profile/controller/efb_profile_controller.dart';
import 'package:get/get.dart';

class EFB_Main_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFB_Home_Controller>(() => EFB_Home_Controller());
    Get.lazyPut<EFB_Device_Controller>(() => EFB_Device_Controller());
    Get.lazyPut<EFB_History_Controller>(() => EFB_History_Controller());
    Get.lazyPut<EFB_Analytics_Controller>(() => EFB_Analytics_Controller());
    Get.lazyPut<EFB_Profile_Controller>(() => EFB_Profile_Controller());
  }
}
