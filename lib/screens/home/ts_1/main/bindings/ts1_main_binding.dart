// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/ts_1/analytics/controller/ts1_analytics_controller.dart';
import 'package:airmaster/screens/home/ts_1/history/controller/ts1_history_controller.dart';
import 'package:airmaster/screens/home/ts_1/home/controller/ts1_home_controller.dart';
import 'package:airmaster/screens/home/ts_1/profile/controller/ts1_profile_controller.dart';
import 'package:get/get.dart';

class TS1_Main_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TS1_Home_Controller>(() => TS1_Home_Controller());
    Get.lazyPut<TS1_Profile_Controller>(() => TS1_Profile_Controller());
    Get.lazyPut<TS1_Analytics_Controller>(() => TS1_Analytics_Controller());
    Get.lazyPut<TS1_History_Controller>(() => TS1_History_Controller());
  }
}
