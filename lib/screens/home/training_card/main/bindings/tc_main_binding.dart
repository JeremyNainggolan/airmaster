// ignore_for_file: camel_case_types

import 'package:airmaster/screens/home/training_card/home/controller/tc_home_controller.dart';
import 'package:airmaster/screens/home/training_card/profile/controller/tc_profile_controller.dart';
import 'package:airmaster/screens/home/training_card/training/controller/tc_training_controller.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/controller/tc_pilot_crew_controller.dart';
import 'package:get/get.dart';

class TC_Main_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TC_Home_Controller>(() => TC_Home_Controller());
    Get.lazyPut<TC_Training_Controller>(() => TC_Training_Controller());
    Get.lazyPut<TC_PilotCrew_Controller>(() => TC_PilotCrew_Controller());
    Get.lazyPut<TC_Profile_Controller>(() => TC_Profile_Controller());
  }
}
